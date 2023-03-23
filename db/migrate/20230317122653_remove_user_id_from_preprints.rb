class RemoveUserIdFromPreprints < ActiveRecord::Migration[7.0]
  def change
    remove_index :preprints, name: :index_preprints_on_user_id
    remove_column :preprints, :user_id
  end
end
