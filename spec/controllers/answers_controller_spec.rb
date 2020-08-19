require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user ) }
  before { login(user) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) } }.to change(Answer, :count).by(1)
      end
      it 'create answer and render question show view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) } }.to_not change(Answer, :count)
      end
      it 're-renders question new view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }
        expect(response).to render_template('questions/show')
      end
    end

    context 'answer belongs to the logged in user' do
      it 'answer user' do
        post :create, params: { question_id: question, user: user, answer: attributes_for(:answer) }
        expect(assigns(:answer).user).to eq user
      end
    end
  end

  describe 'DELETE #destroy' do
    context "author" do
      it 'delete the answer' do
        expect { delete :destroy, params: { id: answer } }.to change( Answer, :count).by(-1)
      end
      it 'redirect to index' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'Non author' do
      let(:user1) { create(:user) }
      before { login(user1) }

      it 'delete the answer' do
        expect { delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
      end
      it 'redirect to index' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to question_path
      end
    end

  end
end
