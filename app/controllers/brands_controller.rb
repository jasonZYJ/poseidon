class BrandsController < ResourcesController

  load_and_authorize_resource

  protected

  def permitted_params
    super + %w(sub_category_id)
  end
end
