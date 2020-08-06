require 'rails_helper'

feature 'User can sign up', %q{
  As an unauthenticated user
  I'd like to be able to sign up
} do

  given(:user) { build(:user) }

  scenario 'Unregistered user tries to sign up' do
    visit new_user_registration_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end
