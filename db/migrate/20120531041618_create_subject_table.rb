class CreateSubjectTable < ActiveRecord::Migration
  def up
    create_table :subjects do |t|
      t.integer :id
      t.string :title
      t.string :remarks
      t.decimal :total, :default => 0.00, :precision => 10, :scale => 2
      t.integer :consumptions_count
      t.references :user
      t.timestamps
    end
  end

  def down
  end
end
