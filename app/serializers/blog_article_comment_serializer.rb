class BlogArticleCommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :commenter_id

  belongs_to :user, foreign_key: 'commenter_id', key: :commenter
  belongs_to :blog_article
  has_one :blog, through: :blog_article
end
