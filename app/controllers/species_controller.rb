class SpeciesController < ApplicationController
  before_action :set_species, only: %i[ show edit update destroy ]

  # GET /species
  def index
    if params[:only_herbivores]
      @species_list = Species.herbivores.order(:name)
      @showing = "only_herbivores"
    elsif params[:only_carnivores]
      @species_list = Species.carnivores.order(:name)
      @showing = "only_carnivores"
    elsif params[:only_omnivores]
      @species_list = Species.omnivores.order(:name)
      @showing = "only_omnivores"
    else
      @species_list = Species.all.order(:name)
      @showing = "all"
    end

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("species_container", render_to_string(action: :index, formats: [:html])),
          turbo_stream.append("modal", "<turbo-stream action='invoke' target='modal' method='hide' selector='#species_container'></turbo-stream>".html_safe)
        ]
      end
    end
  end

  # GET /species/1
  def show
    respond_to do |format|
      format.html { render partial: 'species/show', locals: { species: @species }}
    end
  end

  # GET /species/new
  def new
    @species = Species.new
  end

  # GET /species/1/edit
  def edit
    respond_to do |format|
      format.html { render partial: 'species/form', locals: { species: @species } }
    end
  end

  # POST /species
  def create
    @species = Species.new(species_params)

    if @species.save
      flash[:success] = "#{@species.name} was successfully created."
      redirect_to action: "index"
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("modal", 
            partial: 'species/form', locals: { species: @species }
          )
        end
      end
    end
  end

  # PATCH/PUT /species/1
  def update
    respond_to do |format|
      if @species.update(species_params)
        format.turbo_stream do
          flash[:success] = "Successfully Edited #{@species.name}"
          render turbo_stream: [
            turbo_stream.replace("species_#{@species.id}", partial: 'species/species_row', locals: { species: @species }),
            turbo_stream.append("modal", "<turbo-stream action='invoke' target='modal' method='hide' selector='#species_#{@species.id}'></turbo-stream>".html_safe)
          ]
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("modal", 
            partial: 'species/form', locals: { species: @species }
          )
        end
      end
    end
  end

  # DELETE /species/1 
  def destroy
    @species.destroy!

    respond_to do |format|
      format.turbo_stream do
        flash[:success] = "Successfully Removed #{@species.name}"
        render turbo_stream: turbo_stream.remove(@species)
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_species
      @species = Species.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def species_params
      params.require(:species).permit(:name, :color, :diet_type)
    end
end
