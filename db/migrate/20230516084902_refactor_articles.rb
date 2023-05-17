class RefactorArticles < ActiveRecord::Migration[7.0]
  def change
    drop_table :blog_article_comment_dislikes
    drop_table :blog_article_comment_likes
    drop_table :blog_article_likes
    drop_table :preprint_comments
    drop_table :preprint_users
    drop_table :preprints
    drop_table :blog_article_tags

    rename_table :blog_articles, :articles
    rename_table :blog_article_comments, :comments

    remove_reference :comments, :blog_article
    remove_reference :ratings, :rated_user

    add_reference :ratings, :rating_subject, polymorphic: true

    create_join_table :users, :articles do |t|
      t.index :user_id
      t.index :article_id
      t.timestamps
    end

    create_join_table :articles, :tags do |t|
      t.index :article_id
      t.index :tag_id
      t.timestamps
    end
  end
end
