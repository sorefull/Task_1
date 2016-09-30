json.id @post.id
json.author do
  json.name @post.user.name
  json.role @post.user.role
  json.autor_url user_url(@post.user, format: :json)
end
json.extract! @post, :title, :body, :created_at, :updated_at
json.likes @post.likes do |like|
  json.liked_at like.created_at
  json.liker_url user_url(like.user_id, format: :json)
end
json.url post_url(@post, format: :json)
