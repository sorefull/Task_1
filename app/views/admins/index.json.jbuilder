json.array! @users do |user|
  json.extract! user, :id, :provider, :name, :status
  json.post_count user.posts.count
  json.likes user.likes.count
  json.was_liked user.got_likes
  json.user_url user_url(user, format: :json)
  json.followers user.followers do |follower|
    json.extract! follower, :id, :name
  end
end
