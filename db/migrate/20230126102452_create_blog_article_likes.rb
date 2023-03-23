class CreateBlogArticleLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_article_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :blog_article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
