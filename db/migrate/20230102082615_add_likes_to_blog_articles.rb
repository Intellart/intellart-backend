class AddLikesToBlogArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_articles, :likes, :integer, default: 0
  end
end
