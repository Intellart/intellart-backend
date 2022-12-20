class AddDomainToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :domain, :string
    add_index :users, [:email, :domain], unique: true
  end
end
