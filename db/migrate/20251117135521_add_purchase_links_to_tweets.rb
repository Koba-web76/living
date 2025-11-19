class AddPurchaseLinksToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :url, :string
  end
end
