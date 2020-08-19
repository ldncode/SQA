require 'rails_helper'

feature 'User can create answer to question', %q{
  To answer the question,
  As an authenticated user,
  I would like to be able to create an answer to the question,
  invalid answer create
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:question_id) { question.first.id }
  given(:answer) { create(:answer, question: question, user: user)}

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

    scenario 'invalid answer create' do
      fill_in 'Body', with: ''
      click_on 'Create answer'

      expect(page).to have_content "Body can't be blank"
    end

  end

  describe 'Unauthenticated user' do
    scenario 'answer a question' do
      visit question_path(question)

      expect(page).to_not have_content 'Body answer text'
      expect(page).to_not have_link 'Create answer'
    end
  end

end
