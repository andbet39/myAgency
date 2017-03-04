json.extract! profile, :id, :name, :surname, :avatarimg_url, :agenzia, :created_at, :updated_at
json.url profile_url(profile, format: :json)