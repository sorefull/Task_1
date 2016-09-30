class DeletePostAndUserFromLikes < ActiveRecord::Migration[5.0]
  def up
    Like.all.each do |like|
      like.likable_id = like.post_id
      like.likable_type = like.post.class.to_s
      like.save
    end
    remove_column :likes, :post_id
  end

  def down
    add_column :likes, :post_id, :integer
  end
end