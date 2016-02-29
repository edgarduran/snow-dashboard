class DashboardController < ApplicationController

  def index
    @user_info = current_user
  end

end
