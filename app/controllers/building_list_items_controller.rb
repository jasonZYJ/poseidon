class BuildingListItemsController < ResourcesController

  protected
  def build_resource(*args)
    memoize_resource do
      super.tap do |r|
        r.list = outer
      end
    end
  end

  def permitted_params
    %w(building_site_id plot_ratio portion)
  end

end