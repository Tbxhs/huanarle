class AddIndexToCategory < ActiveRecord::Migration
  def up
    add_index :categories, :user_id
  end

  def down
  end
end
