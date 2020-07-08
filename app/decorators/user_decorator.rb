class UserDecorator < ResourceDecorator

  class << self
    def column_names
      %w(edit name position email mobile look) | (h.current_user.is_administrator? ? ['organisation'] : [])
    end

    def form_element_names
      super | %w(password)
    end

    def tab_names
      %w(visitations agreements leases)
    end
  end

end
