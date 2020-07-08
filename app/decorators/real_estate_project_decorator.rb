class RealEstateProjectDecorator < ResourceDecorator
  delegate_all

  class << self
    def column_names
      %w(look location plot_ratio land_area total_cost investment_plan)
    end

    def form_element_names
      %w(location plot_ratio land_area land_acquisition_fee resettlement_compensation land_transaction_fee building_list duration)
    end
  end

  def investment_plan
    h.link_to h.investment_icon, h.url_for(resource.investment_plan)
  end

end
