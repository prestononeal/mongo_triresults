class Api::RacesController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_race, only: [:show, :update, :destroy]

  # Global exception handler for when a document is not found
  rescue_from Mongoid::Errors::DocumentNotFound do |exception|
    render plain: "woops: cannot find race[#{params[:id]}]", status: :not_found
  end

  # GET api/races
  def index
    if !request.accept || request.accept == "*/*"
      offset = params['']
      render plain: "/api/races, offset=[#{params["offset"]}], limit=[#{params["limit"]}]"
    else
      # real implementation
    end
  end

  # GET api/races/:id
  def show
    if !request.accept || request.accept == "*/*"
      render plain: "/api/races/#{params[:id]}"
    else
      # real implementation
      render json: @race
    end
  end

  # POST api/races
  def create
    if !request.accept || request.accept == "*/*"
      txt = params.key?(:race) ? "#{params[:race][:name]}" : :nothing
      render plain: txt, status: :ok
    else
      race = Race.create(race_params)
      render plain: race.name, status: :created
    end
  end

  # PATCH/PUT api/races/:id
  def update
    if @race.update(race_params)
      render json: @race
    else
      render json: @race.errors, status: :unprocessable_entity
    end
  end

  # DELETE api/races/:id
  def destroy
    @race.destroy
    render :nothing => true, :status => :no_content
  end

  private
   # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def race_params
      params.require(:race).permit(:name, :date, :city, :state, :swim_distance, :swim_units, :bike_distance, :bike_units, :run_distance, :run_units)
    end

end
