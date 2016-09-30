class Response < ActiveRecord::Base
  include Logic
  belongs_to :user_input, polymorphic: true

  def categories
    @categories = Game.find(id).categories
    @categories
  end

  def check_answer(clue_id)
    @clue_answer = Clue.find(clue_id).answer
    @user_answer = answer

    if evaluate_answer(@clue_answer, @user_answer)
      puts "You won $#{Clue.find(clue_id).value}"
    else
      puts "No dice"
    end
  end
end
