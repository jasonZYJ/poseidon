class ResourceDecorator < Draper::Decorator
  include CommonDecorations

  delegate_all

  alias_method :resource, :source

  class << self
    def decorator_class
      self
    end

    def column_names
      (source_class.attribute_names - viewable_blacklist).delete_if { |c| c.include?('_id') }
    end

    def form_column_names
      form_element_names + %w(save)
    end

    def form_element_names
      column_names - actions_column - editable_blacklist
    end

    def inline_editing_names
      form_element_names - editable_blacklist
    end

    def human_names(attrs_nonhuman = columns_names)
      h.human_attrs(source_class, attrs_nonhuman)
    end

    def summary_names
      form_element_names.each_slice(3).to_a
    end

    def editable_blacklist
      []
    end

    def actions_column
      %w(look delete edit)
    end

    def viewable_blacklist
      %w(id created_at updated_at lock_version)
    end

    def table_style
      'table'
    end

    def sortable_columns
      form_element_names - source_class.association_names
    end

    def searchable_columns
      sortable_columns
    end

    def tab_names
      []
    end

  end

  def resource_class
    self.class.source_class
  end

  def human_names(attrs_nonhuman = columns_names)
    self.class.human_names(attrs_nonhuman = columns_names)
  end

  def created_at
    h.l(resource.created_at)
  end

end
