require 'rails_helper'

RSpec.describe 'app/views/users/new', type: :feature do
  scenario 'home page' do
    visit root_url
    expect(page).to have_selector 'h1', text: /Create your Account$/
  end
end