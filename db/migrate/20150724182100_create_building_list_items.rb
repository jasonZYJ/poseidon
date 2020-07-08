class CreateBuildingListItems < ActiveRecord::Migration
  def change
    create_table :building_list_items do |t|
      t.references :building_list,:building_site
      t.decimal :portion, default: 0, precision: 19, scale: 4
      t.decimal :plot_ratio, default: 0, precision: 19, scale: 4
      t.timestamps null: false
    end
  end
end
