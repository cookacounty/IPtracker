class CreateCellCategories < ActiveRecord::Migration
  def change
    create_table :cell_categories do |t|
      t.integer :cdscell_id
      t.integer :category_id
      
      t.timestamps
    end
    add_index :cell_categories, :cdscell_id
    add_index :cell_categories,  :category_id
    add_index :cell_categories, [:category_id, :cdscell_id], unique: true
  end
end
