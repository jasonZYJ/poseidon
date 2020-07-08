class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :name, null: false
      t.decimal :unit_cost, default: 0, precision: 19, scale: 4
      t.references :building_site,index: true
      t.timestamps
    end
  end
end
