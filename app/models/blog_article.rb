class BlogArticle < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :blog_article_comments, class_name: 'BlogArticleComment', dependent: :destroy
  has_many :tags, class_name: 'BlogArticleTag', foreign_key: :blog_article_id, dependent: :destroy
  has_many :likes, class_name: 'BlogArticleLike', foreign_key: :blog_article_id, dependent: :destroy

  include AASM
  aasm column: :status do
    state :draft, initial: true
    state :requested
    state :rejected
    state :published

    event :request_publishing, after: :publishing_requested_notification do
      transitions from: :draft, to: :requested
    end

    event :accept_publishing, after: :publishing_accepted_notification do
      transitions from: :requested, to: :published
    end

    event :reject_publishing, after: :publishing_rejected_notification do
      transitions from: :requested, to: :rejected
    end
  end

  def active_model_serializer
    BlogArticleSerializer
  end

  private

  def publishing_requested_notification
    NotificationMailer.with(blog_article: self).publishing_requested.deliver_now!
  end

  def publishing_accepted_notification
    NotificationMailer.with(blog_article: self).publishing_accepted.deliver_later
  end

  def publishing_rejected_notification
    NotificationMailer.with(blog_article: self).publishing_rejected.deliver_later
  end
end
