class WorkflowRankDecorator < ResourceDecorator

  class <<  self
    def column_names
      super | %w(roles look delete)
    end

    def form_element_names
      %w(minimum_approvers)
    end

    def editable_blacklist
      %w(rank)
    end

  end

  def roles
    resource.memberships.map(&:role).join(',')
  end
end
