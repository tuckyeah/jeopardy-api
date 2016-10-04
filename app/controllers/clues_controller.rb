class CluesController < ApplicationController
# class CluesController < ProtectedController
  before_action :set_clue, only: [:show, :update, :destroy]

  # GET /clues
  # GET /clues.json
  def index
    @clues = Clue.all

    render json: @clues
  end

  # GET /clues/1
  # GET /clues/1.json
  def show
    render json: @clue
  end

  # POST /clues
  # POST /clues.json
  def create
    @clue = Clue.new(clue_params)

    if @clue.save
      render json: @clue, status: :created, location: @clue
    else
      render json: @clue.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clues/1
  # PATCH/PUT /clues/1.json
  def update
    @clue = Clue.find(params[:id])

    if @clue.update(clue_params)
      head :no_content
    else
      render json: @clue.errors, status: :unprocessable_entity
    end
  end

  def validate_answer
    @answer = clue_params[:response]
    @response = Response.find(params[:game_id])
    @response.update(user_answer: @answer, clue_id: params[:clue_id])

    Game.find(params[:game_id]).decrement!(:num_clues)
    puts "Number of clues remaining:"
    puts "#{Game.find(params[:game_id])[:num_clues]}"

    @response.check_answer(params[:clue_id])

    render json: @response
  end

  # DELETE /clues/1
  # DELETE /clues/1.json
  def destroy
    @clue.destroy

    head :no_content
  end

  private

  def set_clue
    @clue = Clue.find(params[:id])
  end

  def clue_params
    params.require(:clue).permit(:question, :answer, :value,
                                 :category_id, :response, :id)
  end
end
