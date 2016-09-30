class GamesController < ApplicationController
  def index
    @games = Game.all
    render json: @games
  end

  def show
  end

  def new
    @game = Game.create
    render json: @game
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def game_params
    params.require(:game).permit(:user_id, :response)
  end

  def set_game
    @game = Game.find(params[:id])
  end

  def set_category
    @category = Game.categories.find(params[:id])
  end
end
