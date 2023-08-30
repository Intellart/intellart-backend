class SectionSerializer < ActiveModel::Serializer
  attributes :id, :type, :position, :data, :version_number, :collaborator_id, :collaborator, :current_editor_id, :active_sections, :time

  def active_sections
    object.article.active_sections
  end

  def collaborator
    object.collaborator&.username
  end

  def current_editor_id
    object.collaborator_id
  end

  def id
    object.editor_section_id
  end

  def time
    object.updated_at
  end
end
