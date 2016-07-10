class Api::EntriesController < ApplicationController

  # GET api/racers/:racer_id/entries
  def index
    if !request.accept || request.accept == "*/*"
      render plain: "/api/racers/#{params[:racer_id]}/entries"
    else
      # real implementation
    end
  end

  # GET api/racers/:racer_id/entries/:id
  def show
    if !request.accept || request.accept == "*/*"
      render plain: "/api/racers/#{params[:racer_id]}/entries/#{params[:id]}"
    else
      # real implementation
    end
  end

end
