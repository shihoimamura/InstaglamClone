class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :picture_id
      t.boolean :is_enabled, null: false, default: true

      t.timestamps
    end
  end
end
