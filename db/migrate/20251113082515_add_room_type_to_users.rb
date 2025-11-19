class AddRoomTypeToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :room_type, :string
  end
end
