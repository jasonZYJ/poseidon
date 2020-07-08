class WorkflowRankMembershipsController < ResourcesController

  protected
  def permitted_params
    super | %w(role_id)
  end
end
