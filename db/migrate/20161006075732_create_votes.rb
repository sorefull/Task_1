class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :votable_id
      t.string :votable_type
      t.string :vote

      t.timestamps
    end
    add_index :votes, [:votable_type, :votable_id]
  end
end
