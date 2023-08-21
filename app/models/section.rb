class Section < ApplicationRecord
  # The type come from the editor, so we need to override active record for types
  self.inheritance_column = nil

  include Broadcastable

  validate :collaborator_invited?

  has_paper_trail if: ->(section) { section.new_version? }

  has_one :image, class_name: 'Image', as: :owner, dependent: :destroy
  has_one :file, class_name: 'Attachment', as: :owner, dependent: :destroy

  belongs_to :article
  belongs_to :collaborator, class_name: 'User'

  after_create lambda {
                 payload = JSON.parse(SectionSerializer.new(self).to_json)
                 payload[:time] = article.content.to_h['time'] if article.content.present?
                 broadcast("ArticleChannel-#{article.id}", 'section', 'create', payload)
               }

  after_destroy lambda {
                  payload = JSON.parse(SectionSerializer.new(self).to_json)
                  payload[:time] = article.content.to_h['time'] if article.content.present?
                  broadcast("ArticleChannel-#{article.id}", 'section', 'destroy', payload)
                }

  after_update lambda {
                 payload = JSON.parse(SectionSerializer.new(self).to_json)
                 payload[:time] = article.content.to_h['time'] if article.content.present?
                 broadcast("ArticleChannel-#{article.id}", 'section', 'update', payload)
               }

  def collaborator_invited?
    return if article.collaborators.pluck(:id).include?(collaborator_id) || collaborator_id == article.author_id

    errors.add(:user_id, "You aren't a collaborator of this document.")
  end

  def lock(user_id)
    editor = User.find(user_id)
    self.current_editor_id = editor.id
    save!
  end

  def locked?
    current_editor_id.present?
  end

  def unlock
    self.current_editor_id = nil
    save!
  end

  def unlocked?
    current_editor_id.nil?
  end

  def self.find(id)
    if id.instance_of?(String)
      find_by(editor_section_id: id)
    else
      super
    end
  end

  def new_version?
    return true unless versions.last&.object.present?

    version_number > versions.last.object.match(/version_number: (\d+\.\d+)/)[1].to_f
  end
end
