module Poseidon
  class ActiveRecord < ActiveRecord::Base
    self.abstract_class=true
    include Resourceful


    if Rails.env.development?
      require_dependency 'shop'
      require_dependency 'lease'
      require_dependency 'agreement'
      require_dependency 'workflow'
      require_dependency 'role'
      require_dependency 'user'
      require_dependency 'organisation'
    end

    self.abstract_class = true

    class << self
      def restricted_resources
        @restricted_resources ||= self.descendants.keep_if { |d| d.ancestors.include?(Restricted) }
      end
    end

    def to_sym
      (to_s || '').titleize.delete(' ').underscore.to_sym
    end
  end
end

