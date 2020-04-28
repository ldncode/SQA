require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'GET #index' do
    let(:questions) { create(:question) }
    let(:answers) { create_list(@questions.answers, 3) }

    before { get :index,  { question_id: questions, id: answers } }

    it 'populates an array of all answers' do
      expect(assigns(:questions.answers)).to match_array(answers)
    end

    it 'renders index views' do
      expect(response).to render_template :index
    end

  end
end
