class AddLikableToLikes < ActiveRecord::Migration[5.0]
  def change
    add_column :likes, :likable_id, :integer
    add_column :likes, :likable_type, :string
  end
end
