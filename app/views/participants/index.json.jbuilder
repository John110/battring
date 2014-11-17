json.array!(@participants) do |participant|
  json.extract! participant, :id, :name, :create_matching_id
  json.url participant_url(participant, format: :json)
end
