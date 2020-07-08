class InvestmentPlansController < ResourcesController

  protected

  def permitted_params
    %w(real_estate_project_id)
  end
end
