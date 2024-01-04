class UserReview < ApplicationRecord
  belongs_to :user
  belongs_to :review

  include AASM
  aasm :status, column: :status do
    state :in_progress, initial: true
    state :awaiting_approval
    state :rejected
    state :accepted
    
    event :finish do
      transitions from: :in_progress, to: :awaiting_approval
    end

    event :reject do
      transitions from: :awaiting_approval, to: :rejected
    end

    event :accept do
      transitions from: :awaiting_approval, to: :accepted
    end

    event :revert do
      transitions from: [:awaiting_approval, :rejected, :accepted], to: :in_progress
    end
  end
end
