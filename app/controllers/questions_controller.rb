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
    @answer =  @question.answers.new
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def destroy
    if current_user.author_of?(@question)
     @question.destroy
     redirect_to questions_path, notice: 'Question deleted'
    else
      redirect_to @question, notice: 'You can not delete question'
    end
  end

  private

  def question_load
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

end
