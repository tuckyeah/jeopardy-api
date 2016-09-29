class Game < ActiveRecord::Base
  after_create :assign_id, :create_response
  has_many :categories, as: :game_cats
  has_one :response
  belongs_to :user

  # On creation of a new game, picks three random categories
  # and updates their game_ids to match this current game id
  def assign_id
    puts "Game id is: #{id}"
    game_id = id
    @categories = Category.where(id: Category.pluck(:id).sample(3))
    @categories.map do |cat|
      cat.game_cats_id = game_id
      cat.game_cats_type = 'Game'
    end
    @categories.each(&:save)
  end

  def create_response
    build_response(game_id: id)
  end
end
