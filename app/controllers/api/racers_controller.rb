class Api::RacersController < ApplicationController
  protect_from_forgery with: :null_session

  # GET api/racers
  def index
    if !request.accept || request.accept == "*/*"
      # stub implementation
      render plain: "/api/racers"
    else
      # real implementation
    end
  end

  # GET api/racers/:id
  def show
    if !request.accept || request.accept == "*/*"
      # stub implementation
      render plain: "/api/racers/#{params[:id]}"
    else
      # real implementation
    end
  end

end
