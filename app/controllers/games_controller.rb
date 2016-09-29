class GamesController < ApplicationController
  def index
    @games = Game.all
    render json: @games
  end

  def show
  end

  def create
    @game = Game.create
    render json: @game
  end

  def update
  end

  def destroy
  end

  private

  def game_params
    params.require(:game).permit(:user_id)
  end
end
