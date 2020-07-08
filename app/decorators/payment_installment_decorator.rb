class PaymentInstallmentDecorator < ResourceDecorator

  class << self
    def column_names
      %w(project_item payment_month amount)
    end

    def form_element_names
      %w(project_item installments amount)
    end
  end

  def payment_month
    "Q#{resource.payment_month}"
  end

end
