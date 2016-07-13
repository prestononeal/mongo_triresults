class Api::EntriesController < ApplicationController
  protect_from_forgery with: :null_session

  # GET api/racers/:racer_id/entries
  def index
    if !request.accept || request.accept == "*/*"
      # stub implementation
      render plain: "/api/racers/#{params[:racer_id]}/entries"
    else
      # real implementation
    end
  end

  # GET api/racers/:racer_id/entries/:id
  def show
    if !request.accept || request.accept == "*/*"
      # stub implementation
      render plain: "/api/racers/#{params[:racer_id]}/entries/#{params[:id]}"
    else
      # real implementation
    end
  end

end
