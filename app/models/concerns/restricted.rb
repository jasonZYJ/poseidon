module Restricted
  extend ActiveSupport::Concern

  module ClassMethods
    def resource_type
      model_name
    end
  end

  def resource_type
    self.class.resource_type
  end

end
