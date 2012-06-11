class AddIndexs < ActiveRecord::Migration
  def up
    add_index :subjects, :user_id
    add_index :consumptions, :category_id
    add_index :consumptions, :user_id
    add_index :consumptions, :subject_id
    add_index :users, :email
    add_index :blogs, :user_id
    add_index :executers, :task_title
  end

  def down
  end
end
