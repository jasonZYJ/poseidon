class RoleUsersController < ResourcesController


  protected

  def build_resource *args
    super.tap do |s|
      s.role ||= outer if outer.is_a?(Role)
    end
  end
  def permitted_params
    %w(user_id)
  end

end
