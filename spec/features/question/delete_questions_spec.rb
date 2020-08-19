require 'rails_helper'

feature 'Author can delete his question', %q{
   As an authenticated user
   User must be the author of the question
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'User can delete his question' do
    # залогинен
    sign_in(user)
    # Зайти на страницу вопр
    visit question_path(question)
    # Кликнуть удалить
    click_on 'Delete'
    # Проверить флеш
    expect(page).to have_content 'Question deleted'
    # проверить отсутствие вопроса
    expect(page).to_not have_content question.title
  end

  scenario 'Non author can not delete question' do
    sign_in(create(:user))
    visit question_path(question)

    expect(page).to_not have_link 'Delete'
  end

  scenario 'Unauthenticated user can not delete question' do
    visit question_path(question)

    expect(page).to_not have_link 'Delete'
  end

end
