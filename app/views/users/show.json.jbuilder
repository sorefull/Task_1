# @user
json.id @user.id
json.name @user.name
json.email @user.email
json.role @user.role
json.url user_url(@user, format: :json)
json.following @user.following do |following|
  json.name following.name
  json.autor_url user_url(following, format: :json)
end
json.followers @user.followers do |follower|
  json.name follower.name
  json.follower_url user_url(follower, format: :json)
end
json.posts @user.posts do |post|
  json.title post.title
  json.created_at post.created_at
  json.post_url post_url(post, format: :json)
end
