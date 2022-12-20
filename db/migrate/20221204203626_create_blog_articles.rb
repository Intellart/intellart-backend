class CreateBlogArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :blog_articles do |t|
      t.references :blog, null: false, foreign_key: true
      t.text :title
      t.text :subtitle
      t.text :content

      t.timestamps
    end
  end
end
