class BuildingSitesController < ResourcesController

  protected

  def permitted_params
    %w(name category_id)
  end

end