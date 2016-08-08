require 'rails'
require 'qiita'

class QiitaExporter
  def self.export
    @@instance ||= self.new
    @@instance.client.create_item(params)
  end

  private
  def client
    @client ||= Qiita::Client.new(access_token: ENV['QIITA_ACCESS_TOKEN'])
  end

  def params
    { title: title, tags: tags, body: body }
  end

  def title
    now = Time.current.in_time_zone('Asia/Tokyo')
    %(#{now.year}/#{now.month}/#{now.day} 朝会まとめ)
  end

  def tags
    {}
  end

  def body

  end
end
