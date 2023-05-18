class Section < ApplicationRecord
  # The id and type come from the editor, so we need to override active record for ids and types
  self.inheritance_column = nil
  self.primary_key = :id

  belongs_to :article
end
