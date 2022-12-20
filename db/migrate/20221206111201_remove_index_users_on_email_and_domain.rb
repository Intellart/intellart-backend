class RemoveIndexUsersOnEmailAndDomain < ActiveRecord::Migration[7.0]
  def change
    remove_index :users, name: :index_users_on_email_and_domain
    remove_column :users, :domain
    add_index :users, :email
    #Ex:- add_index("admin_users", "username")
  end
end
