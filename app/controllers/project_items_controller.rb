class ProjectItemsController < ResourcesController

  protected

  def permitted_params
    %w(building_site_id plot_ratio available_area item_percentage unit_price)
  end

  def build_resource(*args)
    memoize_resource do
      super.tap do |r|
        r.pre_config(outer) if action_name == 'new'
      end
    end
  end

  def create_resource(params)
    r = build_resource(params)
    r.floor_space = (params[:available_area] || 0 / r.plot_ratio)
    r.save!
  end

  def update_resource(params)
    if (params[:available_area] || params[:item_percentage])
      area = params[:available_area].try(:to_f) || (params[:item_percentage].try(:to_f) / 100) * outer.available_area
      resource.update_attributes(floor_space: area / resource.plot_ratio) if area
    end
    super
  end


end