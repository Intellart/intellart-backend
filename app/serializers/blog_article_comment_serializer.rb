class BlogArticleCommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :likes, :dislikes, :created_at, :updated_at, :commenter, :reply_to

  belongs_to :blog_article
  belongs_to :commenter, class_name: 'User', foreign_key: 'commenter_id'
  has_many :replies, class_name: 'BlogArticleComment', foreign_key: 'reply_to_id'
  belongs_to :reply_to, class_name: 'BlogArticleComment', foreign_key: 'reply_to_id', optional: true
end
