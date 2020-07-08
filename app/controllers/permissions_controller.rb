class PermissionsController < ResourcesController

  load_and_authorize_resource

  protected
  def permitted_params
    %w(role_id resource_type can_create can_read can_update can_delete can_transition)
  end
end
