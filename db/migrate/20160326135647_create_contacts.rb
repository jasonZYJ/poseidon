class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :full_name, :position, :email, :telephone, :mobile
      t.boolean :legal_representative, default: false
      t.references :organisation
      t.timestamps null: false
    end
  end
end
