class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.references :owner
      t.timestamps null: false
    end
  end
end
