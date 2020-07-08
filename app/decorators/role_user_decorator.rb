class RoleUserDecorator < ResourceDecorator

  class << self

    def column_names
      %w(user position delete)
    end

    def form_element_names
      super - %w(position)
    end
  end

  def position
    resource.user.position
  end

end
