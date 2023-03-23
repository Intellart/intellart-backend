class PreprintCommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :created_at, :updated_at, :commenter, :reply_to

  belongs_to :preprint
  belongs_to :commenter, class_name: 'User', foreign_key: 'commenter_id'
  has_many :replies, class_name: 'PreprintComment', foreign_key: 'reply_to_id'
  belongs_to :reply_to, class_name: 'PreprintComment', foreign_key: 'reply_to_id', optional: true
end
