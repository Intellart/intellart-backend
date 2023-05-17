class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :likes, :dislikes, :created_at, :updated_at, :commenter, :reply_to

  belongs_to :article
  belongs_to :commenter, class_name: 'User', foreign_key: 'commenter_id'
  has_many :replies, class_name: 'Comment', foreign_key: 'reply_to_id'
  belongs_to :reply_to, class_name: 'Comment', foreign_key: 'reply_to_id', optional: true
end
