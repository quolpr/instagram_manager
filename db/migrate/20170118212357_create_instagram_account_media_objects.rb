class CreateInstagramAccountMediaObjects < ActiveRecord::Migration[5.0]
  def change
    create_table :instagram_account_media_objects do |t|
      t.references :instagram_account, foreign_key: true
      t.string :link
      t.string :media_url
      t.jsonb :tags
      t.datetime :created_time
      t.string :caption
      t.string :media_type
      t.string :instagram_id

      t.timestamps
    end

    add_index :instagram_account_media_objects, :instagram_id, unique: true
  end
end
