class CreateCdscells < ActiveRecord::Migration
  def change
    create_table :cdscells do |t|
      t.string :name
      t.integer :cdslib_id

      t.timestamps
    end
  end
end
