class Like < ApplicationRecord
  belongs_to :tweet, optional: true
  belongs_to :answer, optional: true
  belongs_to :user
  validates_uniqueness_of :tweet_id, scope: :user_id
end
