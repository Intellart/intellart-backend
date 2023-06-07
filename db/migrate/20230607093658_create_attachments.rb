class CreateAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :attachments do |t|
      t.string :asset_id
      t.string :public_id
      t.string :format
      t.integer :version
      t.string :resource_type
      t.datetime :created_at
      t.integer :bytes
      t.integer :width
      t.integer :height
      t.string :folder
      t.string :url
      t.string :secure_url
      t.string :name
      t.references :owner, polymorphic: true
    end
  end
end
