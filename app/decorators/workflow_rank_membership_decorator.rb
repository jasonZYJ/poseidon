class WorkflowRankMembershipDecorator < ResourceDecorator

  class <<  self
    def column_names
      super | %w(role delete)
    end
  end
end
