class CategoryDecorator < ResourceDecorator
  delegate_all

  class << self
    def column_names
      %w(look) | super
    end
  end

end
