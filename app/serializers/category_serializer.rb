class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :complete, :clues
  # has_many :clues
end
