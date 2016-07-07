class GraphCreater

  def initialize(team)
    @team = team
  end

  def create
    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: title)
      f.xAxis(categories: categories)
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

  private

  def this_month
    @team.progresses.last.start_date.month
  end

  def title
    this_month.to_s + '月度' + @team.name
  end

  def categories
    ["United States", "Japan", "China", "Germany", "Franceoehgohgoe"]
  end
end
