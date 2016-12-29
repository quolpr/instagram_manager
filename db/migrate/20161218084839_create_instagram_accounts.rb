class CreateInstagramAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :instagram_accounts do |t|
      t.string :token
      t.string :instagram_id
      t.string :username
      t.string :full_name
      t.string :profile_picture
      t.string :bio
      t.string :website
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
    add_index :instagram_accounts, :instagram_id, unique: true
  end
end
