class AddMemoTable < ActiveRecord::Migration
  def up
    create_table :memos do |t|
      t.integer :id
      t.integer :user_id
      t.text :content, :null => false, :limit => 300
      t.timestamps
    end    
  end

  def down
  end
end
