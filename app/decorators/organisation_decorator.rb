class OrganisationDecorator < ResourceDecorator


  class << self
    def column_names
      %w(look name city province telephone)
    end

    def form_element_names
      %w(name city province telephone address bank account)
    end

    def tab_names
      %w(contacts)
    end
  end

end
