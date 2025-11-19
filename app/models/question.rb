class Question < ApplicationRecord
  belongs_to :user, optional: true       # 投稿者
  has_many :answers, dependent: :destroy # 回答との関連
  has_one_attached :image
  belongs_to :category, class_name: "QuestionCategory", foreign_key: "question_category_id", optional: true


  validates :title, presence: true
  validates :body, presence: true
end