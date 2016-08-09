json.array!(@infos) do |info|
  json.extract! info, :id, :title, :owner, :announce_date
  json.url info_url(info, format: :json)
end
