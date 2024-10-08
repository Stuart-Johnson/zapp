class FoodsController < ApplicationController
  before_action :set_food, only: %i[ show edit update destroy ]

  # GET /foods
  def index
    @foods = Food.all.order(:name)
  end

  # GET /foods/1
  def show
    respond_to do |format|
      format.html { render partial: 'foods/show', locals: { food: @food }}
    end
  end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit
    respond_to do |format|
      format.html { render partial: 'foods/form', locals: { food: @food } }
    end
  end

  # POST /foods
  def create
    @food = Food.new(food_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to @food, notice: "#{@food.name} was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foods/1
  def update
    respond_to do |format|
      if @food.update(food_params)
        format.turbo_stream do
          flash[:success] = "Successfully Edited #{@food.name}"
          render turbo_stream: [
            turbo_stream.replace("food_#{@food.id}", partial: 'foods/food_row', locals: { food: @food }),
            turbo_stream.append("modal", "<turbo-stream action='invoke' target='modal' method='hide' selector='#food_#{@food.id}'></turbo-stream>".html_safe)
          ]
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("modal", 
            partial: 'foods/form', locals: { food: @food }
          )
        end
      end
    end
  end

  # DELETE /foods/1
  def destroy
    @food.destroy!

    respond_to do |format|
      format.turbo_stream do
        flash[:success] = "Successfully Removed #{@food.name}"
        render turbo_stream: turbo_stream.remove(@food)
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @food = Food.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def food_params
      params.require(:food).permit(:name, :supplier, :storage_location, :treat)
    end
end
