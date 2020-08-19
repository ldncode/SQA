class AnswersController < ApplicationController
  before_action :find_question, only: %i[create]
  before_action :find_answer, only: %i[destroy show]

  def show
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to @question, notice: 'Your answer successfully created.'
    else
      render 'questions/show'
    end
  end

  def destroy
    if current_user.author_of?(@answer)
    @answer.destroy
      redirect_to question_path(@answer.question), notice: 'Answer deleted'
    else
      redirect_to question_path(@answer.question), notice: 'You can not delete answer'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

end
