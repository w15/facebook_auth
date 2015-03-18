json.array!(@users) do |user|
  json.extract! user, :id, :uid, :email, :image_url
  json.url user_url(user, format: :json)
end
