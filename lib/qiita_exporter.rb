require 'rails'
require 'qiita'

class QiitaExporter
  def self.export
    @@instance ||= self.new
    @@instance.client.create_item(params)
  end

  def self.client
    @client ||= Qiita::Client.new(access_token: ENV['QIITA_ACCESS_TOKEN'])
  end

  def self.params
    {
      title: title,
      tags: '月曜全体朝会',
      body: body,
      coediting: true
    }
  end

  def self.title
    now = Time.current.in_time_zone('Asia/Tokyo')
    %(#{now.year}/#{now.month}/#{now.day} 月曜全体朝会まとめ)
  end

  def self.body
    body = ""
    Team.all.each do |team|
      body += "## #{team.name} <br> "
      body += "### #{progress(team)} <br>"
      body += "<TODO: ここにグラフを出力して貼ってね> <br> "
      topics = Topic.where(progress_id: team.goals.last.progresses.last.id)
      if topics.present?
        body += "### 先週のトピック <br> "
        topics.each do |topic|
          body += "+ #{topic.content} <br> "
        end
      end
    end
    body
  end

  def self.progress(team)
    goal = team.goals.last
    sum = goal.progresses.sum(:amount)
    "今月の達成度 : #{sum}/#{goal.goal} #{entity(team)} (#{((sum.to_f/goal.goal.to_f) * 100).to_i}%)"
  end

  def self.entity(team)
    return '(件)' if team.orders?
    return '(円)' if team.sales?
  end
end
