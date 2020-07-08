class LeaseDecorator < ResourceDecorator

  class << self

    def column_names
      %w(look lease_number state agreement start_date end_date payment_terms rent_free_days deposit quality_bond daily_rate parking advertising_spot storage_space)
    end

    def form_element_names
      super - %w(state)
    end


    def tab_names
      %w(visitations attachments comments commissions audits)
    end

  end
end
