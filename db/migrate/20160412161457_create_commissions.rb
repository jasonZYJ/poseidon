class CreateCommissions < ActiveRecord::Migration
  def change
    create_table :commissions do |t|
      t.references :lease, null: false
      t.date :start_date, :end_date
      t.decimal :proportion
      t.timestamps null: false
    end
  end
end
