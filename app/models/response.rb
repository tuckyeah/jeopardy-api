class Response < ActiveRecord::Base
  has_many :categories, as: :game_cats
  belongs_to :game

  def categories
    Game.find(id).categories
  end
end
