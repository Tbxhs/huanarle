class AddUserTable < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.integer :id
      t.string :login, :limit => 40
      t.string :email, :limit => 40
      t.string :password_digest
      t.string :avatar
      t.datetime :last_login_at
      t.integer :consumptions_count, :default => 0
      t.integer :subjects_count, :default => 0
      t.integer :recorded_days, :default => 0
      t.timestamps
    end
  end

  

  def down
    drop_table :users
  end  
end
