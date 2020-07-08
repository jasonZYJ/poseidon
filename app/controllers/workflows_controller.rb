class WorkflowsController < ResourcesController

  load_and_authorize_resource

  def show
    redirect_to [resource, :workflow_ranks]
  end

  protected

  def build_resource *args
    super.tap do |s|
      s.owner ||= current_organisation
      s.resource_type = approval_resource_types.first #just for Lease now
    end
  end

  def approval_resource_types
    [Lease.model_name]
  end
end
