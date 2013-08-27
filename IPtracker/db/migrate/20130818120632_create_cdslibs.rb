class CreateCdslibs < ActiveRecord::Migration
  def change
    create_table :cdslibs do |t|
      t.string :name

      t.timestamps
    end
  end
end
