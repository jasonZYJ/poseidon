class AgreementDecorator < ResourceDecorator

  class << self
    def column_names
      %w(look number lease brand shop creator responsible_person required_area expected_rent management_type expanding_region opened_stores expanding_stores created_at)
    end

    def form_element_names
      super - %w(lease created_at creator state)
    end

    def tab_names
      %w(visitations attachments comments)
    end
  end

  def lease
    l = resource.lease
    l.present? ? h.link_to(l,l) : ''
  end
end
