class CreateBuildingSites < ActiveRecord::Migration
  def change
    create_table :building_sites do |t|
      t.string :name, null: false
      t.references :category, index: true
      t.timestamps
    end
  end
end
