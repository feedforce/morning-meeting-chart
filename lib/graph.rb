module Graph
  attr_accessor :team, :goals, :series

  def self.create(goals)
    return LazyHighCharts::HighChart.new('graph') unless goals

    # NOTE: 目標が１つの時は配列の１要素に変換する
    goals = [goals] if goals.instance_of?(Goal)
    init(goals)
    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: title)
      f.xAxis(categories: categories)
      f.series(
        type: 'line',
        name: '合計値',
        data: stacked_data_line,
        dataLabels: {
          enabled: true
        }
      )
    end
  end

  def self.init(goals)
    @team = goals.first.team
    @goals = goals
    set_series
  end

  def self.set_series
    progresses = @goals.flat_map(&:progresses).sort_by!(&:start_date)
    @series = progresses.map(&:amount)
  end

  def self.title
    title = "#{@team.name} : #{@goals.first.date.year} 年 #{@goals.first.date.month} 月"
    if @goals.size < 2
      "#{title}度"
    else
      "#{title} 〜 #{@goals.last.date.year} 年 #{@goals.last.date.month} 月度"
    end
  end

  def self.categories
    @goals.flat_map do |goal|
      goal.progresses.map do |progress|
        category_day(progress)
      end
    end
  end

  def self.category_day(progress)
    "#{progress.start_date.day}〜#{(progress.end_date).day}日"
  end

  def self.stacked_data_line
    sum = 0
    @series.map do |s|
      sum += s
    end
  end
end
