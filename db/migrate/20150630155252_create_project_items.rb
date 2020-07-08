class CreateProjectItems < ActiveRecord::Migration
  def change
    create_table :project_items do |t|
      t.references :building_site,:real_estate_project, null:false
      t.decimal :plot_ratio, default: 0, precision: 19, scale: 4
      t.decimal :floor_space, default: 0, precision: 19, scale: 4
      t.decimal :unit_price, default:0, precision: 19, scale: 4
      t.decimal :total_cost, default:0, precision: 19, scale: 4
      t.decimal :selling_price, default:0, precision: 19, scale: 4
      t.timestamps
    end
  end
end