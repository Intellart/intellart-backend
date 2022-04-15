class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.references :user, foreign_key: { to_table: :users }
      t.references :rated_user, foreign_key: { to_table: :users }
      t.integer :rating

      t.timestamps
    end
  end
end
