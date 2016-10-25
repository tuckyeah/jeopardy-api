class Game < ActiveRecord::Base
  after_create :create_response
  has_many :responses, dependent: :destroy
  belongs_to :user
  has_many :clues, through: :game_clues
  has_many :game_clues

  def create_response
    Response.create(game_id: id, user_id: user_id)
  end

  def self.create_for(params)
    user = User.find(params[:user_id])
    params[:num_categories].to_i > 5 ? num_cats = 5 : num_cats = params[:num_categories].to_i
    this_game = user.games.create
    Category.where(id: Category.pluck(:id).sample(num_cats)).map do |cat|
      cat.clues.each do |clue|
        this_game.game_clues.create(clue: clue)
      # [100, 200, 400, 800, 1000].each do |points|
      #   clue = cat.clues.where(value: points).first
      #   this_game.game_clues.create(clue: clue)
      end
    end
    this_game.update_attributes(num_clues: this_game.game_clues.length)
    this_game
  end

# TODO: add validation in later for larger scale games
# these commented out functions are for future reference.

  # validates :game_clues, length: { minimum: 20 }
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
  #    if game_clues.pluck(:values).uniq.length < 5
  #      errors.add(:game_clues, :invalid)
  #    end
  #  end
end
