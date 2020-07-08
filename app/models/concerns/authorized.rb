module Authorized
  extend ActiveSupport::Concern

  module ClassMethods
    def admin_user
      @user ||= where(is_administrator: true).first
    end
  end

  def has_admin_role?
    roles.map(&:users).try(:flatten).try(:compact).include?(admin_user)
  end

  def has_permission?(action, resource_type)
    Permission.where(resource_type: resource_type, role: roles.pluck(:id)).where("can_#{action}" => true).exists?
  end

end
