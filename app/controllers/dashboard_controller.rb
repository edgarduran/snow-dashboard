class DashboardController < ApplicationController

  def index
    @user_info = current_user
    @stuff     = trailapi_service.some_info
  end

  private

  def trailapi_service
    TrailapiService.new
  end

  def twilio_service
    TwilioService.new
  end

end
