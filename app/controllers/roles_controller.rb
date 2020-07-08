class RolesController < ResourcesController

  load_and_authorize_resource

  def show
    redirect_to [resource, :role_users]
  end

end
