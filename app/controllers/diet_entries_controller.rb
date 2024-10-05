class DietEntriesController < ApplicationController
  before_action :set_animal, only: [:animal_diet, :new, :create, :edit, :update, :destroy]

  def animal_diet
    @diet_entries = @animal.diet_entries.includes(:food)
  end

  def new
    @diet_entry = @animal.diet_entries.build
  end

  def create
    @diet_entry = @animal.diet_entries.build(diet_entry_params)

    if @diet_entry.save
      redirect_to animal_diet_path(@animal), notice: 'Diet entry was successfully created.'
    else
      render :new
    end
  end

  def edit
    @diet_entry = DietEntry.find(params[:id])
  end

  def update
    @diet_entry = DietEntry.find(params[:id])

    if @diet_entry.update(diet_entry_params)
      redirect_to animal_diet_path(@animal), notice: 'Diet entry was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @diet_entry = DietEntry.find(params[:id])
    @diet_entry.destroy
    redirect_to animal_diet_path(@animal), notice: 'Diet entry was successfully deleted.'
  end

  private

  def set_animal
    @animal = Animal.find(params[:animal_id])
  end

  def diet_entry_params
    params.require(:diet_entry).permit(:food_id, :animal_id, meals: {})
  end
end
