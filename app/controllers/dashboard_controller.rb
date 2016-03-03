class DashboardController < ApplicationController

  def index
    @user_info = current_user
    @resorts   = current_user.resorts
  end

  private

  def trailapi_service
    TrailapiService.new
  end

end
