json.id @post.id
json.author do
  json.name @post.user.name
  json.role @post.user.role
  json.autor_url user_url(@post.user, format: :json)
end
json.extract! @post, :title, :body, :created_at, :updated_at
json.url post_url(@post, format: :json)
