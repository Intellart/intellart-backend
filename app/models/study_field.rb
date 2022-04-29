class StudyField < ApplicationRecord
  def active_model_serializer
    StudyFieldSerializer
  end
end
