class Game < ActiveRecord::Base
  after_create :create_response
  has_one :response
  belongs_to :user
  has_many :clues, through: :game_clues
  has_many :game_clues

  def create_response
    build_response(game_id: id, user_id: user_id)
  end

  def self.create_for(params)
    user = User.find(params[:user_id])
    num_cats = params[:num_categories].to_i
    this_game = user.games.create
    Category.where(id: Category.pluck(:id).sample(num_cats)).map do |cat|
      [100, 200, 400, 800, 1000].each do |points|
        if cat.clues.where(value: points).length > 1
          offset_num = cat.clues.where(value: points).length
          clue = cat.clues.where(value: points).offset(rand(offset_num)).first
        else
          clue = cat.clues.where(value: points).first
        end
        this_game.game_clues.create(clue: clue, response_id: this_game[:id]) unless clue.nil?
      end
    end
    this_game.update_attributes(num_clues: this_game.game_clues.length)
    this_game
  end

  # def update_categories
  #   @clues_left = Game.find(params[:id]).game_clues.length
  #   puts "I'm in the Model: #{@clues_left}"
  #   # Game.find(params[:id]).decrement(:num_clues)
  #   # puts "Number of clues remaining:"
  #   # puts "#{Game.find(params[:id])[:num_clues]}"
  # end

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
