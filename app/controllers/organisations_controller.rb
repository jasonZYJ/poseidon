class OrganisationsController < ResourcesController

  load_and_authorize_resource

  def show
    redirect_to [resource, :contacts]
  end

end