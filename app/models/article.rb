class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :likes, dependent: :destroy
  # paper_trail versioning
  has_paper_trail

  include AASM
  aasm column: :status do
    state :draft, initial: true
    state :requested
    state :rejected
    state :published

    event :request_publishing, after: :publishing_requested_notification do
      transitions from: [:draft, :rejected], to: :requested
    end

    event :accept_publishing, after: :publishing_accepted_notification do
      transitions from: :requested, to: :published
    end

    event :reject_publishing, after: :publishing_rejected_notification do
      transitions from: [:requested, :published], to: :rejected
    end
  end

  private

  def publishing_requested_notification
    NotificationMailer.with(article: self).publishing_requested.deliver_now!
  end

  def publishing_accepted_notification
    NotificationMailer.with(article: self).publishing_accepted.deliver_later
  end

  def publishing_rejected_notification
    NotificationMailer.with(article: self).publishing_rejected.deliver_later
  end
end
