class RemoveLikesFromBlogArticles < ActiveRecord::Migration[7.0]
  def change
    remove_column :blog_articles, :likes
  end
end
