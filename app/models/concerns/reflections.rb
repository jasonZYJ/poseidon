module Reflections
  extend ActiveSupport::Concern

  module ClassMethods
    def association_for(s)
      reflect_on_association(s.to_s)
    end

    def class_for(association)
      (reflections[association.to_s]).try(:klass)
    end

    def resource_type_with_ancestors
      ancestors.select { |c| c.ancestors.include?(::ActiveRecord::Base) }.reject { |c| c.abstract_class? || c == ::ActiveRecord::Base }
    end
  end

  def association_for(s)
    self.class.association_for(s)
  end

  def class_for(association)
    self.class.class_for(association)
  end
end