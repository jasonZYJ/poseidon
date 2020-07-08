class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string :name, null: false
      t.string :city, :province, :postcode, :telephone, :email, :address,:registered_address, :bank, :account
      t.references :parent
      t.timestamps
    end
  end
end
