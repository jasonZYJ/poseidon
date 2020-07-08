class CreateRealEstateProjects < ActiveRecord::Migration
  def change
    create_table :real_estate_projects do |t|
      t.string :location, null: false
      t.string :infrastructure
      t.decimal :land_area, default: 0, precision: 19, scale: 4
      t.decimal :land_transaction_fee, default: 0, precision: 19, scale: 4
      t.decimal :resettlement_compensation, default: 0, precision: 19, scale: 4
      t.decimal :land_acquisition_fee, default: 0, precision: 19, scale: 4
      t.decimal :plot_ratio, default: 0, precision: 19, scale: 4
      t.decimal :green_field_ratio, default: 0, precision: 19, scale: 4
      t.decimal :building_density, default: 0, precision: 19, scale: 4
      t.decimal :building_setback_restriction, default: 0, precision: 19, scale: 4
      t.references :organisation,:building_list, index: true
      t.integer :duration
      t.timestamps
    end

  end
end
