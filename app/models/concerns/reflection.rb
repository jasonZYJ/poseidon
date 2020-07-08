module Reflection
  extend ActiveSupport::Concern

  module ClassMethods

    def attributes
      self.columns
    end

    def associations
      @associations ||=
          self.reflect_on_all_associations(:belongs_to) \
               .uniq(&:foreign_key)
    end

    def attributes_by_name
      @_attributes_by_name ||= attributes.index_by(&:name)
    end

    def associations_by_name
      @_associations_by_name ||=
          associations.index_by { |a| a.name.to_s }
    end

    def associations_by_foreign_key
      @_associations_by_foreign_key ||= associations.index_by(&:foreign_key)
    end

    def attribute_association(attribute)
      associations_by_name[attribute.to_s]
    end

    def association_names
      associations_by_name.keys || []
    end

  end

end
