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
    rename_column :articles, :image, :image_url

    remove_reference :comments, :blog_article
    remove_reference :ratings, :rated_user
    remove_reference :articles, :user

    add_column :articles, :article_type, :string

    add_reference :ratings, :rating_subject, polymorphic: true
    add_reference :articles, :author, foreign_key: { to_table: :users }
    add_reference :comments, :article

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

    create_table :sections do |table|
      table.string :editor_section_id, index: { unique: true }
      table.string :type
      table.jsonb :data
      table.float :version_number, default: 1.0
      table.integer :position, unsigned: true
      table.references :article
      table.references :collaborator, foreign_key: { to_table: :users }
    end
  end
end
