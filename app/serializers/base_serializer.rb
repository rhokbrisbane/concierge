class BaseSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false
end