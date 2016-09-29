class GamesController < ApplicationController
  def index
    @games = Game.first # i realize this won't show all games, it's just for testing
    render json: @games.categories
  end
end
