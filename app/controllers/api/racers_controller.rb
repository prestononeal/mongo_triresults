class Api::RacersController < ApplicationController

  # GET api/racers
  def index
    if !request.accept || request.accept == "*/*"
      render plain: "/api/racers"
    else
      # real implementation
    end
  end

  # GET api/racers/:id
  def show
    if !request.accept || request.accept == "*/*"
      render plain: "/api/racers/#{params[:id]}"
    else
      # real implementation
    end
  end

end
