require 'rails_helper'

RSpec.describe 'Sessions controller', type: :feature do
  let(:test_user) { User.new(name: 'Example', email: 'user@user.com') }
  let(:email) { 'user@user.com' }

  scenario 'Correct login attempt' do
    test_user.save
    visit login_path
    fill_in 'Email', with: email
    click_button 'Log in'

    expect(page).to have_selector 'div', text: test_user.name
  end

  scenario 'Login attempt with unregistered email' do
    visit login_path
    fill_in 'Email', with: email
    click_button 'Log in'

    expect(page).to have_selector 'div', text: 'Email not registered.'
  end

  scenario 'Succesful login leads to the user page' do
    test_user.save
    visit login_path
    fill_in 'Email', with: email
    click_button 'Log in'

    expect(page).to have_current_path(user_path(test_user))
  end

  scenario 'Succesful logout' do
    test_user.save
    visit login_path
    fill_in 'Email', with: email
    click_button 'Log in'
    click_link 'Log out'

    expect(page).to_not have_selector 'div', text: test_user.name
  end

  scenario 'Logout redirects to root' do
    test_user.save
    visit login_path
    fill_in 'Email', with: email
    click_button 'Log in'
    click_link 'Log out'

    expect(page).to have_current_path(root_url)
  end
end
