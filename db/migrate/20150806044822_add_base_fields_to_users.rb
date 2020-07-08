class AddBaseFieldsToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :organisation
    add_column :users, :name, :string
    add_column :users, :position, :string
    add_column :users, :phone, :string
    add_column :users, :mobile, :string
    add_column :users, :is_administrator, :boolean, default: false
  end
end
