class Api::ResultsController < ApplicationController
  protect_from_forgery with: :null_session

  # GET api/races/:race_id/results
  def index
    if !request.accept || request.accept == "*/*"
      # stub implementation
      render plain: "/api/races/#{params[:race_id]}/results"
    else
      race=Race.find(params[:race_id])
      entrants = race.entrants
      render template: "api/results_show", :locals => { :entrants => entrants }
    end
  end

  # GET api/races/:race_id/results/:id
  def show
    if !request.accept || request.accept == "*/*"
      # stub implementation
      render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
    else
      result=Race.find(params[:race_id]).entrants.where(:id=>params[:id]).first
      render :partial => "api/result", :object => result
    end
  end

  # PATCH/PUT api/races/:race_id/results/:id
  def update
    entrant = Entrant.find(params[:id])
    r_params = result_params
    if r_params[:swim]
      entrant.swim = entrant.race.race.swim
      entrant.swim_secs = r_params[:swim].to_f
    end
    if r_params[:t1]
      entrant.t1 = entrant.race.race.t1
      entrant.t1_secs = r_params[:t1].to_f
    end
    if r_params[:bike]
      entrant.bike = entrant.race.race.bike
      entrant.bike_secs = r_params[:bike].to_f
    end
    if r_params[:t2]
      entrant.t2 = entrant.race.race.t2
      entrant.t2_secs = r_params[:t2].to_f
    end
    if r_params[:run]
      entrant.run = entrant.race.race.run
      entrant.run_secs = r_params[:run].to_f
    end
    entrant.save
    render :partial => "api/result.json", :object => entrant
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params.require(:result).permit(:swim, :t1, :bike, :t2, :run)
    end

end
