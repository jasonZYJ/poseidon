class PermissionDecorator < ResourceDecorator
  class << self
    def column_names
      %w(edit role resource_type can_create can_read can_update can_delete can_transition)
    end

    def form_element_names
      column_names - %w(edit)
    end

    def editable_blacklist
      column_names
    end

  end

  %w(can_create can_read can_update can_delete can_transition).each { |action|
    self.send(:define_method, action) do
      boolean(action.to_sym)
    end
  }


end
