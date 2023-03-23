class PreprintUser < ApplicationRecord
  belongs_to :preprint
  belongs_to :user

  validates :user_id, uniqueness: { scope: :preprint_id, message: 'This user already exists on this preprint.' }

  def active_model_serializer
    PreprintUserSerializer
  end
end
