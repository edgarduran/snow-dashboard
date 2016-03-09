class ResortsController < ApplicationController

  def index
    @results = trailapi_service.search_results(params)
  end

  def create
    @resort = Resort.new(
                    name:          params[:name],
                    official_name: params[:official_name],
                    state:         params[:state],
                    description:   params[:description],
                    latitude:      params[:latitude],
                    longitude:     params[:longitude],
                    user_id:       params[:user_id].to_i,
                    zip_code:      geocoding_service.zip(params[:latitude].to_f, params[:longitude].to_f)
                        )
    if @resort.save
      redirect_to dashboard_index_path
      flash[:success] = "#{@resort.official_name} has been addes to your dashboard."
    else
      redirect_to '/'
      flash[:error] = "Uh-oh, something went wrong."
    end
  end


  private
  def trailapi_service
    TrailapiService.new
  end

  def geocoding_service
    GeocodingService.new
  end

end
