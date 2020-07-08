class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name,:grade
      t.references :sub_category,:organisation
      t.timestamps null: false
    end
  end
end