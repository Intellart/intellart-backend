class UserReview < ApplicationRecord
  belongs_to :user
  belongs_to :review
  has_one :review_content, class_name: 'Article', dependent: :destroy

  include AASM
  aasm :status, column: :status do
    state :in_progress, initial: true
    state :awaiting_approval
    state :rejected
    state :accepted
    state :awaiting_payout
    state :paid

    event :finish do
      transitions from: :in_progress, to: :awaiting_approval
    end

    event :reject do
      transitions from: :awaiting_approval, to: :rejected
    end

    event :accept do
      transitions from: :awaiting_approval, to: :accepted
    end

    event :process do
      transitions from: :accepted, to: :awaiting_payout
    end

    event :pay do
      transitions from: :awaiting_payout, to: :paid
    end

    event :revert do
      transitions from: [:awaiting_approval, :rejected, :accepted], to: :in_progress
    end

    event :accept_review do
      transitions from: :in_progress, to: :accepted
    end

    event :reject_review do
      transitions from: :in_progress, to: :rejected
    end
  end
end
