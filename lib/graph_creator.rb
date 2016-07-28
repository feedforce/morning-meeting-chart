class GraphCreator
  def initialize(team)
    @team = team
  end

  def create(time)
    set_progresses(time)
    return LazyHighCharts::HighChart.new('graph') if @team.progresses.empty?
    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: title)
      f.xAxis(categories: categories)
      series_data.reverse.each_with_index do |data, i|
        f.series(
          type: 'column',
          name: categories.reverse[i],
          stacking: 'normal',
          data: create_stack_data(data, i)
        )
      end

      f.series(
        type: 'line',
        name: '合計値',
        yAxis: 0,
        data: series_stacked_data_for_line,
        dataLabels: {
          enabled: true
        }
      )
      f.yAxis [
        {
          title: {
            text: entity, margin: 70
          },
          max: max,
          allowDecimals: false,
          plotLines: [
            {
              value: @team.goal,
              color: '#FF0000',
              width: 2,
              label: {
                text: "目標 = #{@team.goal}",
                align: 'left',
                x: 0,
                y: -10
              }
            }
          ]
        }
      ]
      f.legend(align: 'left', verticalAlign: 'middle', y: 75, layout: 'vertical')
    end
  end

  private

  def set_progresses(time)
    @time = time
    @progresses = []
    @team.progresses.order('start_date asc').each do |progress|
      if progress.start_date.year == @time[:year] && progress.start_date.month == @time[:month]
        @progresses << progress
      end
    end
  end

  def title
    "#{@time[:year]}年#{@time[:month]}月度 #{@team.name}"
  end

  def categories
    list = []
    @progresses.each do |progress|
      list << category_day(progress)
    end
    list
  end

  def category_day(progress)
    "#{progress.start_date.day}〜#{(progress.start_date + 4).day}日"
  end

  def series_data
    list = []
    @progresses.each do |progress|
      list.push(progress.amount)
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

  def create_stack_data(data, i)
    tmp = []
    (series_data.size - 1 - i).times { tmp.push(0) }
    (i+1).times { tmp.push(data) }
    tmp
  end

  def max
    if @team.goal > series_data.sum
      @team.goal + 10
    else
      series_data.sum + 10
    end
  end

  def entity
    return '受注件数' if @team.orders?
    return '売上(円)' if @team.sales?
  end
end
