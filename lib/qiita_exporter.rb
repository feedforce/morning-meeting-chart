require 'rails'
require 'qiita'
require 'erb'

class QiitaExporter
  def self.exec
    @@instance ||= self.new
    @@instance.client.create_item(@@instance.params)
  end

  def client
    @client ||= Qiita::Client.new(
      access_token: ENV['QIITA_ACCESS_TOKEN'],
      team: ENV['QIITA_TEAM_NAME']
    )
  end

  def params
    {
      title: title,
      tags: tags,
      body: body,
      coediting: true
    }
  end

  def tags
    [
      { name: '全体朝会', versions: [] }
    ]
  end

  def title
    now = Time.current.in_time_zone('Asia/Tokyo')
    %(#{now.year}/#{now.month}/#{now.day} 月曜全体朝会まとめ)
  end

  def body
    ERB.new(File.read('./lib/template.md'), nil, '-').result(binding)
  end

  def progress(team)
    goal = team.goals.last
    sum = goal.progresses.sum(:amount)
    "今月の達成度 : #{sum}/#{goal.goal} #{entity(team)} (#{((sum.to_f/goal.goal.to_f) * 100).to_i}%)"
  end

  def topics(team)
    Topic.where(progress_id: team.goals.last.progresses.last.id)
  end

  def entity(team)
    return '(件)' if team.orders?
    return '(円)' if team.sales?
  end
end
