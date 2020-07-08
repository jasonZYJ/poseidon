module Copyable
  extend ActiveSupport::Concern
  include Reflections

  module ClassMethods
    def copyable_attributes_blacklist
      %i(id created_at updated_at creator_id updator_id lock_version)
    end

    def copyable_overridden_attributes(source)
      {}
    end

    def copyable_associations
      []
    end
  end

  def copy
    build_copy(self.class, self)
  end

  def deep_copy
    copy.tap { |c| copy_associations(c) }
  end

  def copy_associations(copy)
    self.class.copyable_associations.each do |a|
      send(a).find_each do |source|
        copy.send(a).push(build_copy(class_for(a), source))
      end
    end
  end

  def copied_attributes(klass)
    attributes.reject { |k, v| klass.copyable_attributes_blacklist.include?(k.to_sym) }
  end

  protected

  def build_copy(klass, source)
    klass.new(source.copied_attributes(klass).merge(klass.copyable_overridden_attributes(source)))
  end
end
