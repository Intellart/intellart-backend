class RemoveLikesAndDislikesFromBlogArticleComments < ActiveRecord::Migration[7.0]
  def change
    remove_column :blog_article_comments, :likes
    remove_column :blog_article_comments, :dislikes
  end
end
