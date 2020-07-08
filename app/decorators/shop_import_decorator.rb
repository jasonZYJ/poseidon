class ShopImportDecorator < ResourceDecorator
  class << self
    def form_element_names
      %w( attachment)
    end
  end
end
