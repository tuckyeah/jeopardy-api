class GameSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :over
  # has_many :game_clues
  has_many :clues, through: :game_clues
  belongs_to :user
end
