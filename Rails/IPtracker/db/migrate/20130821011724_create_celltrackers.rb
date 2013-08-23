class CreateCelltrackers < ActiveRecord::Migration
  def change
    create_table :celltrackers do |t|
      t.integer :tracker_id
      t.integer :tracked_id

      t.timestamps
    end
    add_index :celltrackers, :tracker_id
    add_index :celltrackers, :tracked_id
    add_index :celltrackers, [:tracker_id, :tracked_id], unique: true    
  end
end
