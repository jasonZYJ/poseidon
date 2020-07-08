class SubCategoryDecorator < ResourceDecorator

  class << self
    def column_names
      %w(name code)
    end
  end

end
