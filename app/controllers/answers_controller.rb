class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to @question, notice: "回答を投稿しました"
    else
      redirect_to @question, alert: "回答を入力してください"
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :image)
  end
end