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
                    user_id:       params[:user_id].to_i
                        )
    if @resort.save
      redirect_to dashboard_index_path
      flash[:success] = "#{@resort.official_name} has been addes to your dashboard."
    else
      redirect_to '/'
      flash[:erro] = "Uh-oh, something went wrong."
    end
  end


  private
  def trailapi_service
    TrailapiService.new
  end

end
