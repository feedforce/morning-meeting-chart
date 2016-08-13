json.array!(@shared_infos) do |shared_info|
  json.extract! shared_info, :id, :title, :owner, :body, :announce_date
  json.url shared_info_url(shared_info, format: :json)
end
