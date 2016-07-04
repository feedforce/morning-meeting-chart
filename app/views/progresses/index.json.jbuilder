json.array!(@progresses) do |progress|
  json.extract! progress, :id, :amount, :start_date
  json.url progress_url(progress, format: :json)
end
