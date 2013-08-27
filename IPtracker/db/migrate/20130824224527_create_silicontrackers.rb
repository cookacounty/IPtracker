class CreateSilicontrackers < ActiveRecord::Migration
  def change
      create_table :silicontrackers do |t|
        t.integer :silicon_id
        t.integer :cdscell_id
  
        t.timestamps
      end
      
      add_index :silicontrackers, :silicon_id
      add_index :silicontrackers, :cdscell_id
      add_index :silicontrackers, [:silicon_id, :cdscell_id], unique: true

  end
end
