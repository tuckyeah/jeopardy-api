class Game < ActiveRecord::Base
  after_create :assign_category_ids, :create_response
  has_many :categories
  has_one :response, as: :user_input
  belongs_to :user

  # On creation of a new game, picks three random categories
  # and updates their game_ids to match this current game id
  def assign_category_ids
    puts "Game id is: #{id}"
    game_id = id
    @categories = Category.where(id: Category.pluck(:id).sample(3))
    @categories.map { |cat| cat.game_id = game_id }
    @categories.each(&:save)
  end

  def create_response
    build_response(game_id: id, user_id: user_id)
  end
end
