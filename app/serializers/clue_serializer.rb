class ClueSerializer < ActiveModel::Serializer
  attributes :id, :question, :answer, :value
end
