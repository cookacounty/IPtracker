class FixPropsInCdslibsCdscells < ActiveRecord::Migration
  def change
    remove_column :cdslibs, :xsize, :integer
    remove_column :cdslibs, :ysize, :integer
    remove_column :cdslibs, :layimg, :string

    add_column :cdscells, :xsize, :integer
    add_column :cdscells, :ysize, :integer
    add_attachment :cdscells, :layimg, :string
  end
end
