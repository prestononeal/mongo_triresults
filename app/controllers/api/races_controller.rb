class Api::RacesController < ApplicationController
  protect_from_forgery with: :null_session

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
      race = Race.find(params[:id])
      render json: race
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

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def race_params
      params.require(:race).permit(:name, :date, :city, :state, :swim_distance, :swim_units, :bike_distance, :bike_units, :run_distance, :run_units)
    end

end
