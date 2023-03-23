class AddLikesAndDislikesToBlogArticleComments < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_article_comments, :likes, :integer, default: 0
    add_column :blog_article_comments, :dislikes, :integer, default: 0
  end
end
