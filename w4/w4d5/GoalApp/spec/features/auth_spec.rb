require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'username', with: 'capybara'
      fill_in 'password', with: 'password'
      click_on 'Submit'
    end
    scenario "shows username on the homepage after signup" do
      expect(page).to have_content('capybara')
    end
  end
end

feature "the log in process" do
  before(:each) do
    User.create(username: 'capybara', password: 'password')
  end

  scenario "has a log in page" do
    visit new_session_url
    expect(page).to have_content('Login')
  end

  feature "Logging in" do
    before(:each) do
      visit new_session_url
      fill_in 'username', with: 'capybara'
      fill_in 'password', with: 'password'
      click_on 'Submit'
    end
    scenario "shows username after logging in" do
      expect(page).to have_content('capybara')
    end
  end
end

feature "logging out" do
  before(:each) do
    User.create(username: 'capybara', password: 'password')
    visit new_session_url
    fill_in 'username', with: 'capybara'
    fill_in 'password', with: 'password'
    click_on 'Submit'
  end

  scenario "doesn't show username on the homepage after logout" do
    click_on 'logout'
    expect(page).not_to have_content('capybara')
  end

end
