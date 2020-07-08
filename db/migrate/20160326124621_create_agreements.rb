class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.references :shop,:brand, :creator, :responsible_person, :first_party, :second_party
      t.decimal :required_area, :expected_rent
      t.string  :management_type, :expanding_region, :agreement_number, :state
      t.integer :opened_stores, :expanding_stores,:attachments_count, :comments_count
      t.text :renovation_standard, :payment_terms
      t.timestamps null: false
    end
  end
end
