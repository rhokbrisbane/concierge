class ApplicationSerializer < ActiveModel::Serializer
  self.root = false

  embed :ids
end
