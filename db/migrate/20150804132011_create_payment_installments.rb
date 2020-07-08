class CreatePaymentInstallments < ActiveRecord::Migration
  def change
    create_table :payment_installments do |t|
      t.references :investment_plan,:project_item
      t.integer :payment_month
      t.decimal :amount
      t.timestamps null: false
    end
  end
end
