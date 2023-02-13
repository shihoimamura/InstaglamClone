class AddUserIdToPicture < ActiveRecord::Migration[6.1]
  def change
    add_column :pictures, :user_id, :integer
  end
end
