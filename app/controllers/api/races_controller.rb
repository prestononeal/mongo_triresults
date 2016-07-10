class Api::RacesController < ApplicationController

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

end
