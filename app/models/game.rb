class Game < ActiveRecord::Base
  after_create :assign_id
  has_many :categories
  belongs_to :user

  # On creation of a new game, picks three random categories
  # and updates their game_ids to match this current game id
  def assign_id
    puts "Game id is: #{id}"
    game_id = id
    @categories = Category.where(id: Category.pluck(:id).sample(3))
    @categories.map { |cat| cat.game_id = game_id }
    @categories.each(&:save)
  end

# make sure we reset the categories game_ids to nil when we are finished
# i'm going to need a join table i think for these games, where we'll assign ids
end
