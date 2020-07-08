class ResourceTypesController < ResourcesController

  protected
  def permitted_params
    %w(type name)
  end

end
