module Graph

  attr_accessor :team, :goals

  def self.create(goals)
    return LazyHighCharts::HighChart.new('graph') unless goals

    # NOTE: 目標が１つの時は配列の１要素に変換する
    goals = [goals] if goals.instance_of?(Goal)
    @team = goals.first.team
    @goals = goals

    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: title)
      f.xAxis(categories: categories)
    end
  end

  private

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
end
