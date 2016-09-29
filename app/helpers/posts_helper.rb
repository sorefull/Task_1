module PostsHelper
  def can_like?(post)
    !(post.likes.include? current_user.id)
  end
end
