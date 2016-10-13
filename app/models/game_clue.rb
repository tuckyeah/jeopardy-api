class GameClue < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with GameValidator
  belongs_to :game, inverse_of: :game_clues
  belongs_to :clue
  belongs_to :response
end
