class GraphCreater

  def initialize(team)
    @team = team
  end

  def create
    return nil if @team.progresses.empty?

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
        {
          title: {
            text: '獲得件数', margin: 70
          },
          plotLines: [
            {
              value: @team.goal,
              color: '#FF0000',
              width: 2,
              label: {
                text: "目標 = #{@team.goal}",
                align: 'right',
                x: 70,
                y: 5
              }
            }
          ]
        }
      ]
      f.legend(align: 'right', verticalAlign: 'middle', y: 75, x: -50, layout: 'vertical')
    end
  end

  private

  def this_month
    @team.progresses.last.start_date.month
  end

  def title
    "#{this_month}月度 #{@team.name}"
  end

  def categories
    categories = @team.progresses.map do |progress|
      list ||= []
      list << category_day(progress) if progress.start_date.month == this_month
    end
    categories.flatten!
  end

  def category_day(progress)
    "#{progress.start_date.day}〜#{(progress.start_date.day + 5)}日"
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
