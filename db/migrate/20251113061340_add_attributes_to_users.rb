class AddAttributesToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :age_group, :string
    add_column :users, :gender, :string
    add_column :users, :stat, :string
    add_column :users, :room_type, :string
    add_column :users, :area, :string
    remove_column :users, :type, :string
  end
end
