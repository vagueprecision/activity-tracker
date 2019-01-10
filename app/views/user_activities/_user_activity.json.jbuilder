json.extract! user_activity, :id, :performed_at, :name, :created_at, :updated_at
json.url user_activity_url(user_activity, format: :json)
