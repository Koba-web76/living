class MakeTweetAndAnswerNullableInLikes < ActiveRecord::Migration[7.2]
  def change
    change_column_null :likes, :tweet_id, true
    change_column_null :likes, :answer_id, true
  end
end
