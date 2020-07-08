class Ability
  include CanCan::Ability

  class << self
    def basic_actions
      [:create, :read, :update, :delete]
    end

    def transition_actions
      (Lease.events | Agreement.events).deep_dup
    end
  end

  def initialize(user, type=nil)
    alias_action :split, to: :update
    alias_action :merge, to: :create
    self.class.transition_actions.each do |s|
      alias_action s, to: :transition
    end

    if user.blank?
      # not logged in
      cannot :manage, :all

    elsif user.is_administrator?
      # admin
      can :manage, :all
    else
      user.permissions.each do |m|
        self.class.basic_actions.each { |a| can a, m.resource_type.safe_constantize if m.send("can_#{a.to_s}") }
      end
    end
  end

end
