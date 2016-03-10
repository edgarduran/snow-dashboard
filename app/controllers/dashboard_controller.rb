class DashboardController < ApplicationController

  def index
    @presenter = DashboardPresenter.new(current_user)
  end

end
