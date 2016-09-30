class Response < ActiveRecord::Base
  extend Logic
  belongs_to :user_input, polymorphic: true

  def categories
    @categories = Game.find(id).categories
    @categories
  end
end
