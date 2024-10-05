class AnimalsController < ApplicationController
  before_action :set_animal, only: %i[ show edit update destroy restore ]

  # GET /animals
  def index
    if params[:only_active]
      @animals = Animal.active.order(:name)
    elsif params[:only_archived]
      @animals = Animal.archived.order(:name)
    else
      @animals = Animal.all.order(:name)
    end
  end

  # GET /animals/1
  def show
  end

  # GET /animals/new
  def new
    @animal = Animal.new
  end

  # GET /animals/1/edit
  def edit
  end

  # POST /animals
  def create
    @animal = Animal.new(animal_params)

    respond_to do |format|
      if @animal.save
        format.html { redirect_to @animal, notice: "Animal was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /animals/1
  def update
    respond_to do |format|
      if @animal.update(animal_params)
        format.html { redirect_to @animal, notice: "Animal was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animals/1

  def destroy
    if @animal.update(active: false)  # Mark the animal as archived
      redirect_to animals_path, notice: "#{@animal.name} has been archived."
    else
      redirect_to animals_path, alert: "Unable to archive #{@animal.name}."
    end
  end

  def restore
    if @animal.update(active: true)
      redirect_to animals_path, notice: "#{@animal.name} has been restored."
    else
      redirect_to animals_path, alert: "Unable to restore #{@animal.name}."
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def animal_params
      params.require(:animal).permit(:name, :species, :birth_date, :active)
    end
end