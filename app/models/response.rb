class Response < ActiveRecord::Base
  include Logic
  belongs_to :user_input, polymorphic: true

  def categories
    @categories = Game.find(id).categories
    @categories
  end

  def check_answer(clue_id)
    @right_answer = Clue.find(clue_id).answer
    update_attributes(clue_answer: @right_answer)
    Clue.find(clue_id).update_attributes(answered: true)

    if evaluate_answer(clue_answer, user_answer)
      update_attributes(correct: true)
      # @user = Game.find(id).user_id
      # @winnings = Clue.find(clue_id).value
      # @user.update(score: @winnings)
      # @user
    else
      update_attributes(correct: false)
    end
  end
end
