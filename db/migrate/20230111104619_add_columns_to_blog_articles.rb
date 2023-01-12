class AddColumnsToBlogArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_articles, :status, :string
    add_column :blog_articles, :description, :text
    add_column :blog_articles, :image, :string
    add_column :blog_articles, :star, :boolean
    remove_column :blog_articles, :content
    add_column :blog_articles, :content, :jsonb
    add_reference :blog_articles, :category, foreign_key: true
  end
end
