class CreateShoppingMalls < ActiveRecord::Migration
  def change
    create_table :shopping_malls do |t|
      t.text :name
      t.references :owner,:project
      t.timestamps null: false
    end
  end
end
