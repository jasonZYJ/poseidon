class ResourceTypeDecorator < ResourceDecorator
  class << self
    def column_names
      %w(type name)
    end
  end

end
