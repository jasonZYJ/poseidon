class InvestmentPlan < Poseidon::ActiveRecord
  belongs_to :real_estate_project

  has_many :items, class_name: 'PaymentInstallment'
  has_many :payment_installments

  delegate :name,:duration, to: :real_estate_project
end
