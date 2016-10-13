class GameValidator < ActiveModel::Validator
  # this currently doesnt work because we're validating on the game_clue
  # not games
  # we need to validate game_clues on save, and set up that auto save thing
  # so they only validate at the end
  # or change all of gameclues to build a full thing before it tries to save,
  # and to keep doing that until it's full, _then_ create a new game.
  def validate(record)
    if record.clues.pluck(:category_id).uniq.length < 5
      record.errors.add(:game_clues, :invalid)
    elsif record.clues.pluck(:value).uniq.length < 5
      record.errors.add(:game_clues, :invalid)
    end
  end
end
