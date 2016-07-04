json.array!(@topics) do |topic|
  json.extract! topic, :id, :content
  json.url topic_url(topic, format: :json)
end
