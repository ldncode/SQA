require 'rails_helper'

feature 'User can view the question' do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'view question' do
    visit question_path(question)

    expect(page).to have_content 'Question'
    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end

  scenario 'view answers question' do
    visit question_path(question)

    expect(page).to have_content 'MyText'
  end

end
