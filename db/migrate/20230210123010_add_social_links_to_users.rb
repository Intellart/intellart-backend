class AddSocialLinksToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :social_fb, :text
    add_column :users, :social_tw, :text
    add_column :users, :social_ln, :text
    rename_column :users, :social_links, :social_web
  end
end
