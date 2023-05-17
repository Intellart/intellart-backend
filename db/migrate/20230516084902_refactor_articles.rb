class RefactorArticles < ActiveRecord::Migration[7.0]
  def change
    drop_table :blog_article_comment_dislikes
    drop_table :blog_article_comment_likes
    drop_table :blog_article_likes
    drop_table :preprint_comments
    drop_table :preprint_users
    drop_table :preprints

    rename_table :blog_articles, :articles
    rename_table :blog_article_comments, :comments
    rename_table :blog_article_tags, :article_tags

    remove_reference :article_tags, :blog_article
    remove_reference :comments, :blog_article
  end
end
