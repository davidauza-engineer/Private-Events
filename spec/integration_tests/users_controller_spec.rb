require 'rails_helper'

RSpec.describe 'Users controller', type: :feature do
  def fill_sign_up_form
    visit new_user_path
    fill_in 'Name', with: 'Example'
    fill_in 'Email', with: 'example@example.com'
  end

  scenario 'sign up page creates new user' do
    fill_sign_up_form
    expect{ click_button 'Create' }.to change{ User.count }.by(1) 
  end

  scenario 'sign up page redirects to new user' do
    fill_sign_up_form
    click_button 'Create'

    expect(page).to have_current_path('/users/1') 
  end

  scenario 'flash message on succesful sign up' do
    fill_sign_up_form
    click_button 'Create'

    expect(page).to have_selector 'body', text: 'Account created successfully!'
  end
end