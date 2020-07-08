class WorkflowDecorator < ResourceDecorator

  class << self
    def column_names
      %w(look name is_default ranks)
    end

    def form_element_names
      super - %w(ranks)
    end
  end

  def ranks
    resource.ranks.size
  end

  def is_default
    boolean(:is_default)
  end
end
