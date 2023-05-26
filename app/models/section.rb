class Section < ApplicationRecord
  # The type come from the editor, so we need to override active record for types
  self.inheritance_column = nil

  validate :collaborator_invited?

  has_paper_trail if: ->(section) { section.new_version? }

  belongs_to :article
  belongs_to :collaborator, class_name: 'User'

  def collaborator_invited?
    return if article.collaborators.pluck(:id).include?(collaborator_id) || collaborator_id == article.author_id

    errors.add(:user_id, "You aren't a collaborator of this document.")
  end

  def new_version?
    return true if versions.last&.event == 'create'

    version_number != versions.last.object.match(/version_number: (\d+\.\d+)/)[1].to_f
  end
end
