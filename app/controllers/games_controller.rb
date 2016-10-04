class GamesController < ApplicationController
  before_action :set_game, only: [:show]
  before_action :update_categories, only: [:show]
  before_action :game_over?, only: [:show]

  def index
    # @games = current_user.games.where(over: true)
    @games = Game.all
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
    @game = Game.create_for(game_params[:user_id])
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
    @game = current_user.games.where(id: params[:id])
    @game.destroy

    head :no_content
  end

  private

  def game_params
    params.require(:game).permit(:user_id, :num_categories)
  end

  def set_game
    @game = Game.find(params[:id])
  end

  def update_categories
    puts "update categories ran"
    @game = Game.find(params[:id])
    @game.categories.each do |category|
      if category.clues.where(answered: true).length == category.clues.length
        category.update_attributes(complete: true)
      end
    end
  end

  def game_over?
    @game = Game.find(params[:id])
    if @game.categories.where(complete: true).length == @game.categories.length
      @game.update(over: true)
    end
  end
end
