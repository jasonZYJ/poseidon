class CreateSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_categories do |t|
      t.string :name, :code
      t.references :category
      t.timestamps null: false
    end
  end
end
