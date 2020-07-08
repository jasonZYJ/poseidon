class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :role, null:false
      t.string :resource_type, null:false
      t.boolean :can_create, :can_read, :can_update, :can_delete, :can_transition, default: false
      t.timestamps null: false
    end
  end
end
