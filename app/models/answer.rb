class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :likes, dependent: :destroy 
  has_one_attached :image
  validates :body, presence: true
end
