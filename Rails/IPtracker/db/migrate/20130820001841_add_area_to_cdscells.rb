class AddAreaToCdscells < ActiveRecord::Migration
  def change
    add_column :cdscells, :area, :integer
  end
end
