# @user
json.id @user.id
json.name @user.name
json.email @user.email
json.role @user.role
json.likes @user.likes.count
json.was_liked @user.got_likes
json.following @user.following do |following|
  json.name following.name
  json.autor_url api_user_url following
end
json.followers @user.followers do |follower|
  json.name follower.name
  json.follower_url api_user_url follower
end
json.posts @user.posts do |post|
  json.title post.title
  json.likes post.likes.count
  json.created_at post.created_at
  json.post_url api_post_url post
end
