json.array! @users do |user|
  json.extract! user, :id, :provider, :name, :status
  json.post_count user.posts.count
  json.likes user.likes.count
  json.was_liked user.got_likes
  json.user_url api_user_url user
  json.followers user.followers do |follower|
    json.follower_name follower.name
    json.follower_url api_user_url follower
  end
end
