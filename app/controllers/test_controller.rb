class TestController < ApplicationController

  def index
    @chart       = high_charts_service.chart
    @chart_globals = high_charts_service.chart_globals
  end


  def high_charts_service
    HighChartsService.new
  end


end
