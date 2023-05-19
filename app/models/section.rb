class Section < ApplicationRecord
  # The id and type come from the editor, so we need to override active record for ids and types
  self.inheritance_column = nil
  self.primary_key = :id

  validate :collaborator_invited?

  has_paper_trail

  belongs_to :article
  belongs_to :collaborator, class_name: 'User'

  def collaborator_invited?
    return if article.collaborators.pluck(:id).include?(collaborator_id)

    errors.add(:user_id, "You aren't a collaborator of this document.")
  end
end
