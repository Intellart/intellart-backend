class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :full_name, :orcid_id, :study_field,
             :profile_img, :social_web, :social_fb, :social_ln, :social_tw, :created_at, :updated_at,
             :username, :bio

  #has_many :preprint_users, class_name: 'PreprintUser', foreign_key: 'user_id'
  #has_many :preprints, through: :preprint_users, foreign_key: 'user_id'

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def study_field
    object.study_field_id ? StudyField.find(object.study_field_id).field_name : ''
  end
end
