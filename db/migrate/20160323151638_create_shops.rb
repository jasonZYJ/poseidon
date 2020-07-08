class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :building,:level,:number
      t.text :feature, :remark
      t.references :type, :sub_category, :organisation, :parent, :workflow
      t.decimal :bay,:depth,:max_height,:min_height,:bearing,:area, default: 0
      t.boolean :temporary, :is_deleted, :consolidated, default: false
      t.integer :children_count
      t.timestamps null: false
    end
  end
end