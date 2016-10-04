class ClueSerializer < ActiveModel::Serializer
  attributes :id, :question, :value, :category, :answered
  belongs_to :game_clues
end
