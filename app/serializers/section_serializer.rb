class SectionSerializer < ActiveModel::Serializer
  attributes :id, :type, :position, :data, :version_number, :collaborator_id, :collaborator

  def collaborator
    object.collaborator.username
  end

  def id
    object.editor_section_id
  end
end
