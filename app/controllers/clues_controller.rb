class CluesController < ApplicationController
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
    @response = Response.create(answer: @answer)

    if @response.validate
    render json: @response
  end

   # while in here, get the response
   # pass it to the response model
   # and do validation there, before returning to clue controller.

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
      params.require(:clue).permit(:question, :answer, :value, :category_id, :response)
    end
end
