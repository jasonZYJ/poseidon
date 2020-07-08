class CreateWorkflows < ActiveRecord::Migration
  def change
    create_table :workflows do |t|
      t.references :owner
      t.string :name,:resource_type
      t.boolean :is_default, default: false
      t.timestamps null: false
    end
  end
end
