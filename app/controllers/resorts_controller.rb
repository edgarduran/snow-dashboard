class ResortsController < ApplicationController

  def index
    @results = trailapi_service.search_results(params)
  end


  private
  def trailapi_service
    TrailapiService.new
  end

end
