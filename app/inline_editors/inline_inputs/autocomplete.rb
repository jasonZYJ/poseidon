module InlineInputs
  class Autocomplete < Base

    def config
      super.merge({:type => 'select2'})
    end

    protected

    def placeholder
      association ? translated_model : I18n.t(attr_name)
    end

    def translated_model
      I18n.t(:search_for, :models => resource.class.human_attribute_name(association.name.to_s))
    end

    def association
      @association ||= resource.class.reflect_on_all_associations(:belongs_to).uniq(&:foreign_key).select { |a| a.foreign_key.to_s == attr_name.to_s }.first
    end
  end
end
