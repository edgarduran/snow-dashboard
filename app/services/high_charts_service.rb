class HighChartsService

  def chart
    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Snow last 25 days")
      f.xAxis(categories: ["Snow"])
      f.series(name: "Inches", yAxis: 0, data: [14])

      f.yAxis [
        {title: {text: "Inches of snow", margin: 12} },
        {title: {text: " "}, opposite: true, margin: 120},
      ]
      f.legend(enabled: false)
      f.chart({defaultSeriesType: "column", height: 200})
    end
  end

  def chart_globals
    LazyHighCharts::HighChartGlobals.new do |f|
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

end
