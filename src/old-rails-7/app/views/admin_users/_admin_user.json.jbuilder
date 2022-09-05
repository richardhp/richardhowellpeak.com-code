json.extract! admin_user, :id, :email, :password, :created_at, :updated_at
json.url admin_user_url(admin_user, format: :json)
