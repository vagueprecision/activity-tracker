json.extract! auth, :id, :name, :principal, :created_at, :updated_at
json.url auth_url(auth, format: :json)
