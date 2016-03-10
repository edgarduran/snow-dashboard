class DashboardPresenter
  attr_reader :user_info,
              :resorts,
              :states,
              :forecast,
              :recent_snow,
              :chart,
              :chart_globals

  def initialize(current_user)
    @user_info = current_user
  end

  def resorts
    @user_info.resorts
  end

  def forecast
    @forecast ||= ForecastService.new.three_day_forecast(resorts)
  end

  def recent_snow
    @recent_snow ||= HistoricalSnowfallService.new.twenty_five_day_snow(resorts)
  end

  def high_charts_service
    @high_cart ||= HighChartsService.new
  end

  def chart
    high_charts_service.chart(recent_snow, resorts)
  end

  def chart_globals
    high_charts_service.chart_settings
  end

  def states
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
