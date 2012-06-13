class AddCategoryTable < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.integer :id
      t.integer :parent_id, :default => 0
      t.integer :user_id
      t.string :name
      t.timestamps
    end    
  end

  def down
  end
end
