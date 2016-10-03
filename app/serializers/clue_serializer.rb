class ClueSerializer < ActiveModel::Serializer
  attributes :id, :question, :value, :category, :answered
end
