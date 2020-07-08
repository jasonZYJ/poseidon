class VisitationDecorator < ResourceDecorator

  class << self
    def column_names
      %w(contact remark duration creator created_at)
    end

    def form_element_names
      column_names - %w(creator created_at)
    end

  end

end
