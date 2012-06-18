class AddFeedBackTable < ActiveRecord::Migration
  def up
    create_table :feed_backs do |t|
      t.integer :id
      t.integer :user_id
      t.text :content
      t.timestamps
    end
    add_index :feed_backs, :user_id
  end


  def down
  end
end
