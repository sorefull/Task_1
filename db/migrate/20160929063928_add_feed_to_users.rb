class AddFeedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :feed, :text
  end
end
