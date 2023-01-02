class AddLikesAndDislikesToBlogArticleComments < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_article_comments, :likes, :integer
    add_column :blog_article_comments, :dislikes, :integer
  end
end
