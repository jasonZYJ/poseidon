class CreateLeases < ActiveRecord::Migration
  def change
    create_table :leases do |t|
      t.date :start_date, :end_date
      t.text :payment_terms
      t.integer :rent_free_days, :attachments_count, :comments_count
      t.decimal :deposit, :quality_bond, :storage_space, :daily_rate
      t.references :agreement, null: false
      t.references :creator, :responsible_person, :first_party, :second_party, :shop, :brand, :workflow
      t.integer :parking, :advertising_spot
      t.string :state, :lease_number
      t.timestamps null: false
    end
  end
end
