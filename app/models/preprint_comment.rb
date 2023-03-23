class PreprintComment < ApplicationRecord
  belongs_to :preprint
  belongs_to :commenter, class_name: 'User', foreign_key: :commenter_id
  belongs_to :reply_to, class_name: 'PreprintComment', foreign_key: :reply_to_id, optional: true, dependent: :destroy
  has_many :replies, class_name: 'PreprintComment', foreign_key: :reply_to_id, dependent: :destroy

  def active_model_serializer
    PreprintCommentSerializer
  end
end
