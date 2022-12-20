class Blog < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: :user_id
  has_many :blog_articles, class_name: 'BlogArticle'
  has_many :blog_article_comments, through: :blog_articles
end
