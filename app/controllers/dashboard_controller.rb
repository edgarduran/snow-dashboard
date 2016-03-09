class DashboardController < ApplicationController

  def index
    @user_info   = current_user
    @resorts     = current_user.resorts
    @states      = state_list
    @forecast    = forecast_service.three_day_forecast(@resorts)
    @recent_snow = historical_snowfall_service.twenty_five_day_snow(@resorts)
    @chart       = chart
    @chart_globals = chart_globals
  end

  private

  def forecast_service
    ForecastService.new
  end

  def historical_snowfall_service
    HistoricalSnowfallService.new
  end

  def chart
    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Population vs GDP For 5 Big Countries [2009]")
      f.xAxis(categories: ["United States", "Japan", "China", "Germany", "France"])
      f.series(name: "GDP in Billions", yAxis: 0, data: [14119, 5068, 4985, 3339, 2656])
      f.series(name: "Population in Millions", yAxis: 1, data: [310, 127, 1340, 81, 65])

      f.yAxis [
        {title: {text: "GDP in Billions", margin: 70} },
        {title: {text: "Population in Millions"}, opposite: true},
      ]

      f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
      f.chart({defaultSeriesType: "column"})
    end
  end

  def chart_globals

    @chart_globals = LazyHighCharts::HighChartGlobals.new do |f|
      f.global(useUTC: false)
      f.chart(
        backgroundColor: {
          linearGradient: [0, 0, 500, 500],
          stops: [
            [0, "rgb(255, 255, 255)"],
            [1, "rgb(240, 240, 255)"]
          ]
        },
        borderWidth: 2,
        plotBackgroundColor: "rgba(255, 255, 255, .9)",
        plotShadow: true,
        plotBorderWidth: 1
      )
      f.lang(thousandsSep: ",")
      f.colors(["#90ed7d", "#f7a35c", "#8085e9", "#f15c80", "#e4d354"])
    end
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
