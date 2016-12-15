class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :instagram_token
      t.string :instagram_id, index: true, unique: true

      t.string :username
      t.string :full_name
      t.string :profile_picture
      t.string :bio
      t.string :website

      t.timestamps
    end
  end
end
