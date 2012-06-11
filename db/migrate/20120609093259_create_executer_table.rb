class CreateExecuterTable < ActiveRecord::Migration
  def up
    create_table :executers do |t|
      t.integer :id
      t.string :task_title
      t.datetime :start_time
      t.datetime :end_time
      t.integer :do_times
      t.integer :done_times
    end
  end

  def down
  end
end
