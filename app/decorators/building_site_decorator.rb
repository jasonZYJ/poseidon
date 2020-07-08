class BuildingSiteDecorator < ResourceDecorator
  delegate_all

  class << self
    def column_names
      %w(look category name)
    end
  end
end
