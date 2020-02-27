require 'rails_helper'

RSpec.describe 'Tests for events controller', type: :feature do
  let(:test_user) { User.new(name: 'Test', email: 'test@user.com') }
  let(:test_event_one) { Event.new(name: 'Event_1', date: 2.days.after, creator_id: 1) }
  let(:test_event_two) { Event.new(name: 'Event_2', date: 4.days.after, creator_id: 1) }

  def log_in_user
    visit login_path
    fill_in 'Email', with: 'test@user.com'
    click_button 'Log in'
  end

  scenario 'display all the events at the index action' do
    test_user.save
    test_event_one.save
    test_event_two.save
    visit events_path
    expect(page).to have_selector('li', text: 'Event_2')
  end

  scenario 'the show view displays the right event' do
    test_user.save
    test_event_one.save
    visit event_path(test_event_one)
    expect(page).to have_selector('h1', text: 'Event_1')
  end

  scenario 'the new action displays the correct form if user is logged in' do
    test_user.save
    log_in_user
    visit new_event_path
    expect(page).to have_selector('label', text: 'Description')
  end

  scenario 'a new event is created after submitting the form if the user is logged in' do
    test_user.save
    log_in_user
    visit new_event_path
    fill_in 'Name', with: 'Test Event'
    fill_in 'Date', with: 1.day.after
    fill_in 'Description', with: 'Cool Description'
    expect{ click_button('Create') }.to change{ Event.count }.by(1)
  end

  scenario 'a user is asked to log in before being able to create a new event' do
    visit new_event_path
    expect(current_path).to eq(login_path)
  end
end