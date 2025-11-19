class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_question, only: [:show, :destroy]  # ← 追加

  def index
    @questions = Question.order(created_at: :desc)

    if params[:question_category_ids].present?
      @questions = @questions.where(question_category_id: params[:question_category_ids])
    end
  end

  def show
    @answers = @question.answers.order(created_at: :asc)
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      redirect_to @question, notice: "質問を投稿しました"
    else
      render :new
    end
  end

  def destroy
    if @question.user == current_user
      @question.destroy
      redirect_to questions_path, notice: "質問を削除しました。"
    else
      redirect_to questions_path, alert: "削除できません。"
    end
  end

  private

  def set_question
    @question = Question.find_by(id: params[:id])
    redirect_to questions_path, alert: "質問が見つかりません" unless @question
  end

  def question_params
    params.require(:question).permit(:title, :body, :image, :question_category_id)
  end
end