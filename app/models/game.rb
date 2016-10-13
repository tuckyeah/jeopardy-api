class Game < ActiveRecord::Base
  validates :game_clues, length: {maximum: 25}
  after_create :create_response
  has_many :responses
  belongs_to :user
  has_many :clues, through: :game_clues
  has_many :game_clues

  def create_response
    Response.create(game_id: id, user_id: user_id)
  end

  def fill_game_clues
    Category.where(id: Category.pluck(:id)).sample(self.num_categories).each do |cat|
      clues = Clue.by_value(cat[:id])
      clues.each_key do |points|
        clue = clues[points].sample(1)[0]
        self.game_clues.create(clue: clue) if self.check_validation(clue)
      end
    end
  end

  def check_validation(clue)
    self.game_clues.new(clue: clue).valid?
  end

  # TODO: break this into smaller functions
  def self.create_for(params)
    user = User.find(params[:user_id])
    params[:num_categories].to_i > 5 ? num_cats = 5 : num_cats = params[:num_categories].to_i
    this_game = user.games.create(num_categories: num_cats)
    this_game.fill_game_clues until this_game.game_clues.length == this_game.num_categories * 2
    this_game.update(num_clues: this_game.game_clues.length)
  end
end
