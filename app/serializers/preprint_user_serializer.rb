class PreprintUserSerializer < ActiveModel::Serializer
  attributes :id, :preprint_id, :user_id

  belongs_to :user
  belongs_to :preprint
end
