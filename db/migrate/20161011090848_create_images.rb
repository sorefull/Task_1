class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :file
      t.string :imagable_type
      t.integer :imagable_id

      t.timestamps
    end
    add_index :images, [:imagable_type, :imagable_id]
  end
end
