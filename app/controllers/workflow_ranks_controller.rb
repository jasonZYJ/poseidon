class WorkflowRanksController < ResourcesController

  def show
    redirect_to [resource, :workflow_rank_memberships]
  end
end
