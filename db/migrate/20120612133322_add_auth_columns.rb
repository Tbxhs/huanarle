class AddAuthColumns < ActiveRecord::Migration
  def up
    add_column :users, :weibo_uid, :string
    add_column :users, :weibo_token, :string
  end

  def down
  end
end
