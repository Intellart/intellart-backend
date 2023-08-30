class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :commenter, class_name: 'User', foreign_key: :commenter_id
  belongs_to :reply_to, class_name: 'Comment', foreign_key: :reply_to_id, optional: true
  has_many :replies, class_name: 'Comment', foreign_key: :reply_to_id, dependent: :destroy
  has_many :ratings, as: :rating_subject, dependent: :destroy

  include Rateable
end
