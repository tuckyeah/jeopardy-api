class Game < ActiveRecord::Base
  require 'csv'
  after_create :assign_category_ids, :create_response, :reset_clues
  has_many :categories
  has_one :response, as: :user_input
  belongs_to :user
  # On creation of a new game, picks three random categories
  # and updates their game_ids to match this current game id
  def assign_category_ids
    puts "Game id is: #{id}"
    game_id = id
    num_cats = num_categories.to_i
    @categories = Category.where(id: Category.pluck(:id).sample(num_cats))
    @categories.map { |cat| cat.game_id = game_id }
    @categories.each(&:save)
  end

  def create_response
    build_response(game_id: id, user_id: user_id)
  end

  def reset_clues
    @categories = Category.where(game_id: id)
    @categories.each do |category|
      category.clues.each { |clue| clue.update_attributes(answered: false) }
      category.update_attributes(complete: false)
    end
  end
end
