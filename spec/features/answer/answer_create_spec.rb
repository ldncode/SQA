require 'rails_helper'

feature 'User can create answer to question', %q{
  To answer the question,
  As an authenticated user,
  I would like to be able to create an answer to the question
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:question_id) { question.first.id }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'answer a question' do
      fill_in 'Body', with: 'Body answer text'
      click_on 'Create answer'

      expect(page).to have_content 'Your answer successfully created.'
      expect(page).to have_content 'Body answer text'

    end

    scenario 'An unauthenticated user tries to create an answer' do
      fill_in 'Body', with: 'Body answer text'
      click_on 'Create answer'

      save_and_open_page

      expect(page).to have_content 'Your answer successfully created.'
    end

  end

end
