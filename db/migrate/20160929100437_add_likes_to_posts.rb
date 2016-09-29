class AddLikesToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :likes, :text
  end
end
