class BrandDecorator < ResourceDecorator

  class << self
    def column_names
      %w(name grade sub_category category organisation)
    end

    def form_element_names
      %w(name grade sub_category organisation)
    end

  end

  def category
    sub_category.try(:category)
  end

end
