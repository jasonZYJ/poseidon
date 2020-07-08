class RealEstateProjectsController < ResourcesController

  protected

  def permitted_params
    %w(location plot_ratio land_area land_acquisition_fee resettlement_compensation land_transaction_fee building_list_id duration)
  end

end