class Article < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :ratings, as: :rating_subject, dependent: :destroy
  has_many :sections, dependent: :destroy
  has_and_belongs_to_many :collaborators, class_name: 'User', join_table: 'articles_users', foreign_key: 'article_id'
  has_and_belongs_to_many :tags, join_table: 'articles_tags', foreign_key: 'article_id'
  # paper_trail versioning
  has_paper_trail

  accepts_nested_attributes_for :tags

  include Rateable

  include AASM
  aasm :status, column: :status do
    state :draft, initial: true
    state :requested
    state :rejected
    state :published

    # event :request_publishing, after: :publishing_requested_notification do
    #   transitions from: [:draft, :rejected], to: :requested
    # end

    # event :accept_publishing, after: :publishing_accepted_notification do
    #   transitions from: :requested, to: :published
    # end

    # event :reject_publishing, after: :publishing_rejected_notification do
    #   transitions from: [:requested, :published], to: :rejected
    # end

    event :request_publishing do
      transitions from: :draft, to: :published
    end
  end

  aasm :article_type, column: :article_type do
    state :blog_article
    state :preprint
    state :scientific_article

    event :convert_to_preprint do
      transitions from: :blog_article, to: :preprint
    end

    event :convert_to_scientific_article do
      transitions from: :preprint, to: :scientific_article
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
