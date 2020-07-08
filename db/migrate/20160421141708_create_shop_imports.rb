class CreateShopImports < ActiveRecord::Migration
  def change
    create_table :shop_imports do |t|
      t.integer "organisation_id"
      t.attachment :attachment
      t.string "status"
      t.timestamp :null => false
    end
  end
end
