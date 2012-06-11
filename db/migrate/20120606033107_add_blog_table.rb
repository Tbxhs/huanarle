class AddBlogTable < ActiveRecord::Migration
  def up
    create_table :blogs do |t|
      t.integer :id
      t.integer :user_id
      t.string :title
      t.text :content
      t.timestamps
    end    
  end


  def down
  end
end
