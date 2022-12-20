class CreateBlogArticleComments < ActiveRecord::Migration[6.1]
  def change
    create_table :blog_article_comments do |t|
      t.references :blog_article, null: false, foreign_key: true
      t.references :commenter, foreign_key: { to_table: :users }
      t.text :comment

      t.timestamps
    end
  end
end
