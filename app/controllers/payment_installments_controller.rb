class PaymentInstallmentsController < ResourcesController

  protected

  def permitted_params
    %w(project_item_id amount payment_month)
  end

  def create_resource args
    params[:installments].each do |i|
      args.merge!({payment_month: i[0][1..-1], amount:i[1], investment_plan: outer})
       resource_class.create(args) if i[1].to_f > 0
    end
  end

end
