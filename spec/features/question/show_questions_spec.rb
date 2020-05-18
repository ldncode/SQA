require 'rails_helper'

feature 'User can view the questions', %q{
    User can see the question,
    The user can create an answer to a question,
    The user should see the answers to the question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'list questions' do
    visit questions_path

    expect(page).to have_content 'List questions'
    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end

  scenario 'see to question and answers' do
    visit question_path(question)

    

  end
  scenario 'create an answer to a question'
end
