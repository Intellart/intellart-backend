class Preprint < ApplicationRecord
  has_many :preprint_users, class_name: 'PreprintUser', foreign_key: 'preprint_id'
  has_many :users, through: :preprint_users, foreign_key: 'preprint_id'
  has_many :preprint_comments, class_name: 'PreprintComment', dependent: :destroy
  # has_many :tags, class_name: 'BlogArticleTag', dependent: :destroy
  # has_many :likes, class_name: 'BlogArticleLike', dependent: :destroy

  # paper_trail versioning
  has_paper_trail

  include AASM
  aasm column: :status do
    state :draft, initial: true
    state :requested
    state :rejected
    state :published

    event :request_publishing, after: :preprint_publishing_requested_notification do
      transitions from: [:draft, :rejected], to: :requested
    end

    event :accept_publishing, after: :preprint_publishing_accepted_notification do
      transitions from: :requested, to: :published
    end

    event :reject_publishing, after: :preprint_publishing_rejected_notification do
      transitions from: [:requested, :published], to: :rejected
    end
  end

  def active_model_serializer
    PreprintSerializer
  end

  private

  def preprint_publishing_requested_notification
    NotificationMailer.with(preprint: self).preprint_publishing_requested.deliver_now!
  end

  def preprint_publishing_accepted_notification
    NotificationMailer.with(preprint: self).preprint_publishing_accepted.deliver_later
  end

  def preprint_publishing_rejected_notification
    NotificationMailer.with(preprint: self).preprint_publishing_rejected.deliver_later
  end
end
