class AddCategoryIdToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :category_id, :integer
    add_index :tweets, :category_id
  end
end
