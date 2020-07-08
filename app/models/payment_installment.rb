class PaymentInstallment < Poseidon::ActiveRecord
  belongs_to :investment_plan
  belongs_to :project_item

  delegate :duration, to: :investment_plan
  delegate :name, to: :project_item
end
