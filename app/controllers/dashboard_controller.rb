class DashboardController < ApplicationController

  def index
    # decorator
    # @dashboard_presenter = DashboardPresenter.new(current_user)

    @user_info   = current_user
    @resorts     = current_user.resorts
    @states      = state_list
    @forecast    = forecast_service.three_day_forecast(@resorts)
    @recent_snow = historical_snowfall_service.twenty_five_day_snow(@resorts)
    @chart       = high_charts_service.chart(@recent_snow, @resorts)
    @chart_globals = high_charts_service.chart_globals
  end

  private

  def forecast_service
    @forecast_service ||= ForecastService.new
  end

  def historical_snowfall_service
    @recent_snow ||= HistoricalSnowfallService.new
  end

  def high_charts_service
    @chart ||= HighChartsService.new
    @chart_globals ||= HighChartsService.new
  end

  def state_list
    state_abbr = {
        'AK' => 'Alaska', 'AZ' => 'Arizona',
        'CA' => 'California', 'CO' => 'Colorado',
        'CT' => 'Connecticut', 'DE' => 'Delaware',
        'DC' => 'District of Columbia', 'ID' => 'Idaho',
        'IL' => 'Illinois', 'IN' => 'Indiana',
        'IA' => 'Iowa', 'KS' => 'Kansas',
        'KY' => 'Kentucky', 'ME' => 'Maine',
        'MD' => 'Maryland', 'MA' => 'Massachusetts',
        'MI' => 'Michigan', 'MN' => 'Minnesota',
        'MT' => 'Montana', 'NE' => 'Nebraska',
        'NV' => 'Nevada', 'NH' => 'New Hampshire',
        'NJ' => 'New Jersey', 'NM' => 'New Mexico',
        'NY' => 'New York', 'NC' => 'North Carolina',
        'ND' => 'North Dakota', 'OH' => 'Ohio',
        'OR' => 'Oregon', 'PA' => 'Pennsylvania',
        'RI' => 'Rhode Island', 'SD' => 'South Dakota',
        'TN' => 'Tennessee', 'TX' => 'Texas',
        'UT' => 'Utah', 'VT' => 'Vermont',
        'VA' => 'Virginia', 'WA' => 'Washington',
        'WV' => 'West Virginia', 'WI' => 'Wisconsin',
        'WY' => 'Wyoming'
    }
  end

end
