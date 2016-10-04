class Response < ActiveRecord::Base
  include Logic
  has_many :game_clues

  def categories
    @categories = Game.find(id).categories
    @categories
  end

  def check_answer(clue_id)
    remove_clue(clue_id)

    @right_answer = Clue.find(clue_id).answer
    update_attributes(clue_answer: @right_answer)

    if evaluate_answer(clue_answer, user_answer)
      increment_score(clue_id)
      update_attributes(correct: true)
    else
      update_attributes(correct: false)
    end
  end

  def remove_clue(clue_id)
    @game = Game.find(game_id)
    @game_clue_id = @game.game_clues.where(clue_id: clue_id).ids[0]
    Game.find(game_id).game_clues.destroy(@game_clue_id)
  end

  private

  def increment_score(clue_id)
    @user = User.find(Game.find(id).user_id)
    @winnings = Clue.find(clue_id).value
    @winnings = @winnings += @user.score
    @user.update(score: @winnings)
  end
end
