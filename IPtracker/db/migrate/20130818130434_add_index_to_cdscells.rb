class AddIndexToCdscells < ActiveRecord::Migration
  def change
    add_index :cdscells, [:cdslib_id]
  end
end
