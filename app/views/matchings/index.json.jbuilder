json.array!(@create_matchings) do |create_matching|
  json.extract! create_matching, :id, :name, :owner, :title, :reguration, :limit, :start, :memo, :participant_id
  json.url create_matching_url(create_matching, format: :json)
end
