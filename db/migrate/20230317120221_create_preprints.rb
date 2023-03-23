class CreatePreprints < ActiveRecord::Migration[7.0]
  def change
    create_table :preprints do |t|
      t.references :user, null: false, foreign_key: true
      t.text :title
      t.text :subtitle
      t.string :status
      t.text :description
      t.string :image
      t.boolean :star
      t.jsonb :content
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
