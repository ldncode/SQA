class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :question_load, only: %i[show destroy]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def show
    @answer =  Answer.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Question deleted'
  end

  private

  def question_load
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

end
