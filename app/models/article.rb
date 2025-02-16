class Article < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :user_review, optional: true
  has_many :comments, dependent: :destroy
  has_many :ratings, as: :rating_subject, dependent: :destroy
  has_many :sections, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_and_belongs_to_many :collaborators, class_name: 'User', join_table: 'articles_users', foreign_key: 'article_id'
  has_and_belongs_to_many :tags, join_table: 'articles_tags', foreign_key: 'article_id'
  has_one :image, class_name: 'Image', as: :owner, dependent: :destroy

  accepts_nested_attributes_for :tags

  include Rateable
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  include AASM
  aasm :status, column: :status do
    state :draft, initial: true
    state :requested
    state :rejected
    state :published
    state :reviewing

    event :request_publishing do #, after: :publishing_requested_notification do
      transitions from: [:draft, :reviewing, :rejected, :published], to: :requested
    end

    event :accept_publishing do  #, after: :publishing_accepted_notification do
      transitions from: [:draft, :requested, :reviewing, :rejected], to: :published
    end

    event :reject_publishing do  #, after: :publishing_rejected_notification do
      transitions from: [:requested, :published, :reviewing], to: :rejected
    end

    event :reviewing do
      transitions from: [:draft, :published], to: :reviewing
    end

    event :finish_reviewing do
      transitions from: :reviewing, to: :published
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

  def slug_candidates
    [
      :title,
      %i[id title]
    ]
  end

  def should_generate_new_friendly_id?
    title_changed? || super
  end

  def active_sections
    payload = {}
    sections.where.not(collaborator_id: nil).each do |section|
      payload[section.editor_section_id] = section.collaborator_id
    end
    payload
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
