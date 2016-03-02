class DashboardController < ApplicationController

  def index
    @user_info = current_user
  end

  private

  def trailapi_service
    TrailapiService.new
  end

end
 
