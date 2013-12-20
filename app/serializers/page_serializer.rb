class PageSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :sort
end
