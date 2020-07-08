class BuildingListItemDecorator < ResourceDecorator
  delegate_all

  class << self
    def column_names
      %w(building_site plot_ratio portion)
    end

  end
end
