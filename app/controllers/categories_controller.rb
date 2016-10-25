class CategoriesController < OpenReadController
  before_action :set_category, only: [:show, :update, :destroy, :clues]
  before_action :admin_check, only: [:create, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all

    render json: @categories
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    render json: @category
  end

  def clues
    @clues = @category.clues.where(answered: false)
    render json: @clues
  end

  # POST /categories
  # POST /categories.json
  def create
    return head :unauthorized unless current_user[:is_admin]

    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    return head :unauthorized unless current_user[:is_admin]
    @category = Category.find(params[:id])

    if @category.update(category_params)
      head :no_content
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    return head :unauthorized unless current_user[:is_admin]
    @category.destroy

    head :no_content
  end

  def random
    cat_num = rand(Category.all.length + 1).to_i
    @category = Category.find(cat_num)

    @clue = @category.clues.sample
    render json: [@category.name, @clue]
  end

  private

  def admin_check
    User.where(email: 'admin@admin').ids[0] == current_user[:id]
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :clue_id)
  end
end
