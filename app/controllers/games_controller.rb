class GamesController < ProtectedController
  before_action :set_game, only: [:show]
  # before_action :update_categories, only: [:show]
  before_action :game_over?, only: [:show]

  def index
    @games = current_user.games.where(over: true)
    # @games = Game.all
    render json: @games
  end

  def show
    render json: @game
  end

  # def new
  #   @game = Game.create
  #   render json: @game
  # end

  def create
    @game = Game.create_for(game_params)
    @clues = []

    @game.game_clues.each do |game_clue|
      @clues << Clue.find(game_clue[:clue_id])
    end

    render json: @game
  end

  def update
    @game = current_user.games.where(id: params[:id])
    @game.update(game_params)

    render json: @game
  end

  def destroy
    @game = current_user.games.find_by(id: params[:id])
    @game.destroy

    head :no_content
  end

  def update_categories
    @clues_left = Game.find(params[:id]).game_clues.length
    puts "I'm in the controller: #{@clues_left}"
    # Game.find(params[:id]).decrement(:num_clues)
    # puts "Number of clues remaining:"
    # puts "#{Game.find(params[:id])[:num_clues]}"
  end

  private

  def game_params
    params.require(:game).permit(:user_id, :num_categories)
  end

  def set_game
    @game = current_user.games.find(params[:id])
  end

  def game_over?
    @game = Game.find(params[:id])
    @game.update(over: true) if @game[:num_clues].zero?
    puts "I RAN"
  end
end
