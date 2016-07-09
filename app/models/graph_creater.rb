class GraphCreater

  def initialize(team)
    @team = team
  end

  def create
    return nil if @team.progresses.empty?
    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: title)
      f.xAxis(categories: categories)
      series_data.reverse.each_with_index do |data, i|
        f.series(
          type: 'column',
          name: "Week #{series_data.size - i}",
          stacking: 'normal',
          data: create_stack_data(data, i)
        )
      end
      f.series(
        type: 'line',
        name: 'sum',
        yAxis: 0,
        data: series_stacked_data_for_line,
        dataLabels: {
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

  def series_data
    list = []
    @team.progresses.each do |progress|
      list.push(progress.amount) if progress.start_date.month == this_month
    end
    list
  end

  def series_stacked_data_for_line
    sum = 0
    list = []
    series_data.each do |s|
      list.push(sum += s)
    end
    list
  end

  def create_stack_data (data,i)
    tmp = []
    (i+1).times { tmp.push(data) }
    (series_data.size - 1 - i).times { tmp.unshift(0) }
    tmp
  end
end
