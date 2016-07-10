class Api::RacesController < ApplicationController
  protect_from_forgery with: :null_session

  # GET api/races
  def index
    if !request.accept || request.accept == "*/*"
      render plain: "/api/races"
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
    end
  end

  # POST api/races
  def create
    if !request.accept || request.accept == "*/*"
      render plain: :nothing, status: :ok
    else
    # real implementation
    end
  end

end
