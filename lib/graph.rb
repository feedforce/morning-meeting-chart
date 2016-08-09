module Graph
  attr_accessor :team, :goals, :series

  def self.create(goals)
    return LazyHighCharts::HighChart.new('graph') unless goals

    # NOTE: 目標が１つの時は配列の１要素に変換する
    if goals.is_a?(Array)
      multi_goals(goals)
    else
      single_goals(goals)
    end

    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: @title)
      f.xAxis(categories: @categories)
      @series.each_with_index do |amount, n|
        f.series(
          type: 'column',
          name: @categories.reverse[n],
          stacking: 'normal',
          data: stacked_data_column(amount, n)
        )
      end
      f.series(
        type: 'line',
        name: '合計値',
        data: stacked_data_line,
        dataLabels: {
          enabled: true
        }
      )
      f.yAxis [y_axis]
      f.legend(align: 'left', verticalAlign: 'middle', y: 75, layout: 'vertical')
      f.chart({ height: 500 })
    end
  end

  def self.single_goals(goals)
    @team = goals.team
    @goals = goals
    @title = "#{@team.name} : #{@goals.date.year}年#{@goals.date.month}月"
    @categories = single_categories
    @series = single_series
    @goal = goals.goal
  end

  def self.multi_goals(goals)
    @categories = multi_categories
    @series = multi_series
  end

  def self.single_series
    progresses = @goals.progresses.to_a.sort_by!(&:start_date)
    progresses.map(&:amount).reverse
  end

  def self.single_categories
    @goals.progresses.map do |progress|
      category_day(progress)
    end
  end

  def self.category_day(progress)
    "#{progress.start_date.day}〜#{(progress.end_date).day}日"
  end

  def self.stacked_data_line
    sum = 0
    @series.reverse.map do |s|
      sum += s
    end
  end

  def self.stacked_data_column(amount, n)
    tmp = []
    (@series.size - 1 - n).times { tmp.push(0) }
    (n + 1).times { tmp.push(amount) }
    tmp
  end

  def self.y_axis
    {
      title: {
        text: entity,
        margin: 10
      },
      max: max,
      allowDecimals: false,
      plotLines: [
        {
          value: @goal,
          color: '#FF0000',
          width: 2,
          label: {
            text: "目標 = #{@goal}",
            aligin: 'left',
            x: 0,
            y: -10
          }
        }
      ]
    }
  end

  def self.goal
    @goals.map(&:goal).inject(:+)
  end

  def self.max
    upper = @team.orders? ? 10 : 100_000_00
    max = @series.inject(:+)
    if @goal > max
      @goal + upper
    else
      max + upper
    end
  end

  def self.entity
    return '受注件数' if @team.orders?
    return '売上(円)' if @team.sales?
  end
end
