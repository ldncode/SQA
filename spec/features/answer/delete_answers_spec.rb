require 'rails_helper'

feature 'Author can delete his answer to the question', %q{
   As an authenticated user
   User must be the author of the response
} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }

  scenario 'User can delete his answer to the question' do
    sign_in(user)
    visit question_path(question)

    click_on 'Delete answer'

    expect(page).to have_content 'Answer deleted'
    expect(page).to_not have_content 'answer.body'
  end

  scenario 'Non author can not delete answer' do
    sign_in(create(:user))
    visit question_path(question)

    expect(page).to_not have_link 'Delete answer'
  end

  scenario 'Unauthenticated user can not delete question' do
    visit question_path(question)

    expect(page).to_not have_link 'Delete answer'
  end

end
