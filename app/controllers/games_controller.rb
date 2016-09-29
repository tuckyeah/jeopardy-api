class GamesController < ApplicationController
  def index
    @categories = Category.take(3)
    render json: @categories
  end
end
