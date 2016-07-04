json.array!(@teams) do |team|
  json.extract! team, :id, :name, :goal
  json.url team_url(team, format: :json)
end
