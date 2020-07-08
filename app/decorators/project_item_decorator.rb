class ProjectItemDecorator < ResourceDecorator
  delegate_all

  class << self
    def column_names
      %w(category building_site plot_ratio floor_space available_area item_percentage unit_price actual_cost total_cost actual_total_cost delete)
    end

    def form_element_names
      %w(building_site plot_ratio available_area item_percentage unit_price)
    end
  end

  def item_percentage
    percentage (:item_percentage)
  end

  def available_area
    resource.available_area.round(2)
  end

  def actual_cost
    resource.building_site.unit_cost
  end

  def actual_total_cost
    actual_cost * available_area
  end


end
