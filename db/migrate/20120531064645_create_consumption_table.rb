class CreateConsumptionTable < ActiveRecord::Migration
  def up
    create_table :consumptions do |t|
      t.integer :id
      t.integer :category_id
      t.string :title
      t.decimal :cost, :default => 0.00, :precision => 10, :scale => 2
      t.references :subject
      t.references :user
      t.timestamps
    end    
  end

  def down
  end
end
