json.extract! search, :id, :keyword, :zona, :last_run, :created_at, :updated_at
json.url search_url(search, format: :json)