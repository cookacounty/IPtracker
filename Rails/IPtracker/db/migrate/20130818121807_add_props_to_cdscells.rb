class AddPropsToCdscells < ActiveRecord::Migration
  def change
    add_column :cdslibs, :xsize, :integer
    add_column :cdslibs, :ysize, :integer
    add_attachment :cdslibs, :layimg, :string
  end
end
