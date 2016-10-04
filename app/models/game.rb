class Game < ActiveRecord::Base
  # after_create :create_response
  has_one :response
  belongs_to :user
  has_many :clues, through: :game_clues
  has_many :game_clues
  # On creation of a new game, picks three random categories
  # and updates their game_ids to match this current game id
  # def assign_category_ids
  #   puts "Game id is: #{id}"
  #   game_id = id
  #   num_cats = num_categories.to_i
  #   @categories = Category.where(id: Category.pluck(:id).sample(num_cats))
  #   @categories.map { |cat| cat.game_id = game_id }
  #   @categories.each(&:save)
  # end

  # def create_response
  #   build_response(game_id: id, user_id: user_id)
  # end

  def self.create_for(user_id)
    user = User.find(user_id)
    # num_cats = num_categories.to_i
    this_game = user.games.create
    [100, 200, 400, 800, 1000].each do |points|
      Category.where(id: Category.pluck(:id).sample(5)).map do |cat|
        if cat.clues.where(value: points).length > 1
          offset_num = cat.clues.where(value: points).length
          clue = cat.clues.where(value: points).offset(rand(offset_num)).first
        else
          clue = cat.clues.where(value: points).first
        end
        this_game.game_clues.create(clue: clue) unless clue.nil?
      end
    end
    this_game
  end
  #
  # validates :game_clues, length: { minimum: 5 }, on: :create
  # validate :must_have_clues_from_5_categories
  # validate :must_have_proper_range_of_points
  #
  #  protected
  #
  #  def must_have_clues_from_5_categories
  #    if game_clues.pluck(:category_id).uniq.length < 5
  #      errors.add(:game_clues, :invalid)
  #    end
  #  end
  #
  #  def must_have_proper_range_of_points
  #    if game_clues.pluck(:points).uniq.length < 5
  #      errors.add(:game_clues, :invalid)
  #    end
  #  end
end



 #

 # end



#
# validate :must_have_clues_from_5_categories
# validate :must_have_proper_range_of_points
#
# protected
#
# def must_have_clues_from_5_categories
#   if game_clues.pluck(:category_id).uniq.length < 5
#     errors.add(:game_clues, :invalid)
#   end
# end
#
# def must_have_proper_range_of_points
#   if game_clues.pluck(:points).uniq.length < 5
#     errors.add(:game_clues, :invalid)
#   end
# end



  # def reset_clues
  #   @categories = Category.where(game_id: id)
  #   @categories.each do |category|
  #     category.clues.each { |clue| clue.update_attributes(answered: false) }
  #     category.update_attributes(complete: false)
  #   end
  # end

  # def self.validate_clues(categories)
  #   categories.each do |cat|
  #     cat.clues.length >= 5
  #   end
  # end
