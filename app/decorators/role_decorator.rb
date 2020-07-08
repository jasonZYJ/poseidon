class RoleDecorator < ResourceDecorator

  class << self

    def column_names
      %w(look name users)
    end

    def form_element_names
      super - %w(users)
    end

    def tab_names
      %w(role_users permissions)
    end
  end

  def users
    resource.users.map(&:name).join(',')
  end

end
