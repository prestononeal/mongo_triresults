class Api::ResultsController < ApplicationController

  # GET api/races/:race_id/results
  def index
    if !request.accept || request.accept == "*/*"
      render plain: "/api/races/#{params[:race_id]}/results"
    else
      # real implementation
    end
  end

  # GET api/races/:race_id/results/:id
  def show
    if !request.accept || request.accept == "*/*"
      render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
    else
      # real implementation
    end
  end

end
