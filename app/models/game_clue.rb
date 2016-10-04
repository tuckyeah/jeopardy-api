class GameClue < ActiveRecord::Base
  belongs_to :game, inverse_of: :game_clues
  belongs_to :clue, inverse_of: :game_clues
  belongs_to :response
end
