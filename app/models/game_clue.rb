class GameClue < ActiveRecord::Base
  belongs_to :game, inverse_of: :game_clues
  belongs_to :clue
  belongs_to :response
  # validates_associated :clue, length: { minimum: 5 }, on: :create
  # validates_associated :game
end
