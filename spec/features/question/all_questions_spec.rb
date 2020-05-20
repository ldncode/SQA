require 'rails_helper'

feature 'User can view the all questions' do

  given(:user) { create(:user) }
  given!(:question) { create_list(:question, 3) }

  scenario 'All questions' do
    visit questions_path

    expect(page).to have_content 'All questions'

    question.each do |q|
      expect(page).to have_content q.title
    end

  end
end
