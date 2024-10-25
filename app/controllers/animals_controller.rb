class AnimalsController < ApplicationController
  before_action :set_animal, only: %i[ show edit update destroy restore ]

  # GET /animals
  def index
    if params[:only_active]
      @animals = Animal.active.order(:name)
      @showing = "active"
    elsif params[:only_archived]
      @animals = Animal.archived.order(:name)
      @showing = "archived"
    else
      @animals = Animal.all.order(:name)
      @showing = "both"
    end

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("animals_container", render_to_string(action: :index, formats: [:html])),
          turbo_stream.append("modal", "<turbo-stream action='invoke' target='modal' method='hide' selector='#animals_container'></turbo-stream>".html_safe)
        ]
      end
    end
  end

  # GET /animals/1
  def show
    respond_to do |format|
      format.html { render partial: 'animals/show', locals: { animal: @animal }}
    end
  end

  # GET /animals/new
  def new
    @animal = Animal.new
  end

  # GET /animals/1/edit
  def edit
    respond_to do |format|
      format.html { render partial: 'animals/form', locals: { animal: @animal } }
    end
  end

  # POST /animals
  def create
    @animal = Animal.new(animal_params)

    if @animal.save
      flash[:success] = "#{@animal.name} was successfully created."
      redirect_to action: "index"
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("modal", 
            partial: 'animals/form', locals: { animal: @animal }
          )
        end
      end
    end
  end

  # PATCH/PUT /animals/1
  def update
    respond_to do |format|
      if @animal.update(animal_params)
        format.turbo_stream do
          flash[:success] = "Successfully Edited #{@animal.name}"
          render turbo_stream: [
            turbo_stream.replace("animal_#{@animal.id}", partial: 'animals/animal_row', locals: { animal: @animal }),
            turbo_stream.append("modal", "<turbo-stream action='invoke' target='modal' method='hide' selector='#animal_#{@animal.id}'></turbo-stream>".html_safe)
          ]
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("modal", 
            partial: 'animals/form', locals: { animal: @animal }
          )
        end
      end
    end
  end

  # DELETE /animals/1

  def destroy
    respond_to do |format|
      if @animal.update(active: false)
        format.turbo_stream do
          flash[:success] = "Successfully Archived #{@animal.name}"
          render turbo_stream: [
            turbo_stream.replace("animal_#{@animal.id}", partial: 'animals/animal_row', locals: { animal: @animal }),
            turbo_stream.append("modal", "<turbo-stream action='invoke' method='rebind' selector='#animal_#{@animal.id}'></turbo-stream>".html_safe)
          ]
        end
      else
        format.turbo_stream do
          flash[:alert] = "Failed to Archive #{@animal.name}"
          render turbo_stream: [
            turbo_stream.replace("animal_#{@animal.id}", partial: 'animals/animal_row', locals: { animal: @animal }),
            turbo_stream.append("modal", "<turbo-stream action='invoke' method='rebind' selector='#animal_#{@animal.id}'></turbo-stream>".html_safe)
          ]
        end
      end
    end
  end

  def restore
    respond_to do |format|
      if @animal.update(active: true)
        format.turbo_stream do
          flash[:success] = "Successfully Restored #{@animal.name}"
          render turbo_stream: [
            turbo_stream.replace("animal_#{@animal.id}", partial: 'animals/animal_row', locals: { animal: @animal }),
            turbo_stream.append("modal", "<turbo-stream action='invoke' method='rebind' selector='#animal_#{@animal.id}'></turbo-stream>".html_safe)
          ]
        end
      else
        format.turbo_stream do
          flash[:alert] = "Failed to Restore #{@animal.name}"
          render turbo_stream: [
            turbo_stream.replace("animal_#{@animal.id}", partial: 'animals/animal_row', locals: { animal: @animal }),
            turbo_stream.append("modal", "<turbo-stream action='invoke' method='rebind' selector='#animal_#{@animal.id}'></turbo-stream>".html_safe)
          ]
        end
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def animal_params
      params.require(:animal).permit(:name, :species_id, :birth_date, :active)
    end
end
