class Response < ActiveRecord::Base
  belongs_to :user_input, polymorphic: true

  def categories
    Game.find(id).categories
  end
end
