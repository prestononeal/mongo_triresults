class Api::RacesController < ApplicationController
  protect_from_forgery with: :null_session

  # Global exception handler for when a document is not found
  rescue_from Mongoid::Errors::DocumentNotFound do |exception|
    msg = "woops: cannot find race[#{params[:id]}]"
    if !request.accept || request.accept == "*/*"
      render plain: msg, status: :not_found
    else
      render :status => :not_found,
             :template => "api/error_msg",
             :locals => { :msg=>msg }
    end
  end

  # Global exception handler for when an unsupported content-type is attempted
  rescue_from ActionView::MissingTemplate do |exception|
    content_type = "#{request.accept}"
    render plain: 'woops: we do not support that content-type[' + content_type + ']',
      status: :unsupported_media_type
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
      race = Race.find(params[:id])
      # real implementation
      render :status => :ok,
             :template => "api/race_show",
             :locals => { :name=>race.name, :date=>race.date }
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
    race = Race.find(params[:id])
    if race.update(race_params)
      render json: race
    else
      render json: race.errors, status: :unprocessable_entity
    end
  end

  # DELETE api/races/:id
  def destroy
    race = Race.find(params[:id])
    race.destroy
    render :nothing => true, :status => :no_content
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def race_params
      params.require(:race).permit(:name, :date, :city, :state, :swim_distance, :swim_units, :bike_distance, :bike_units, :run_distance, :run_units)
    end

end
