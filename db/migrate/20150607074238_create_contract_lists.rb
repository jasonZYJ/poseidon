class CreateContractLists < ActiveRecord::Migration
  def change
    create_table :contract_lists do |t|
      t.string :name, null: false
      t.references :owner, index: true
      t.timestamps
    end
  end
end
