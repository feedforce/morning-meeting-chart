class GraphCreater

  def initialize(team)
    @team = team
  end

  def create
    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: title)
      f.xAxis(categories: categories)
      f.series(type: 'column', stacking: 'normal', yAxis: 0, data: series_stacked_data)
      f.series(
        type: 'line',
        yAxis: 0,
        data: series_stacked_data,
        dataLabels:{
          enabled: true
        }
      )
      f.yAxis [
        {title: {text: "GDP in Billions", margin: 70} },
        {title: {text: "Population in Millions"}, opposite: true},
      ]

      f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
      f.chart({defaultSeriesType: "column"})
    end
  end

  private

  def this_month
    @team.progresses.last.start_date.month
  end

  def title
    this_month.to_s + '月度' + @team.name
  end

  def categories
    categories = @team.progresses.map do |progress|
      list ||= []
      list << category_day(progress) if progress.start_date.month == this_month
    end
    categories.flatten!
  end

  def category_day(progress)
    progress.start_date.day.to_s + '〜'+(progress.start_date.day + 5).to_s + '日'
  end

  def series_stacked_data
    sum = 0
    series = @team.progresses.map do |progress|
      list ||= []
      sum += progress.amount if progress.start_date.month == this_month
      list << sum
    end
  end
  end
end
