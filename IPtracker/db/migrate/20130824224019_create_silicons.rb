class CreateSilicons < ActiveRecord::Migration
  def change
    create_table :silicons do |t|
      t.string :name
      t.timestamps
    end
  end
end
