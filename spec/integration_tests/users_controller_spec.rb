require 'rails_helper'

RSpec.describe 'Users controller', type: :feature do
  let(:name) { 'Example' }
  let(:email) { 'example@example.com' }

  def fill_sign_up_form(name, email)
    visit new_user_path
    fill_in 'Name', with: name
    fill_in 'Email', with: email
  end

  scenario 'sign up page creates new user' do
    fill_sign_up_form(name, email)
    expect{ click_button 'Create' }.to change{ User.count }.by(1) 
  end

  scenario 'sign up page redirects to new user' do
    fill_sign_up_form(name, email)
    click_button 'Create'

    expect(page).to have_current_path('/users/1') 
  end

  scenario 'flash message on successful sign up' do
    fill_sign_up_form(name, email)
    click_button 'Create'

    expect(page).to have_selector 'body', text: 'Account created successfully!'
  end

  scenario 'sign up fails' do
    fill_sign_up_form('', email)
    click_button 'Create'

    expect(page).to have_selector "input[value='#{email}']"
  end

  scenario 'flash error message is present after a sign up failure' do
    fill_sign_up_form('', email)
    click_button 'Create'

    expect(page).to have_selector 'body', text: "Name can't be blank"
  end
end