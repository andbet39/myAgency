json.extract! interaction, :id, :type, :vote, :interest, :note, :listing_id, :user_id, :created_at, :updated_at
json.url interaction_url(interaction, format: :json)