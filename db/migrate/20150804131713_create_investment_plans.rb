class CreateInvestmentPlans < ActiveRecord::Migration
  def change
    create_table :investment_plans do |t|
      t.references :real_estate_project
      t.timestamps null: false
    end
  end
end
