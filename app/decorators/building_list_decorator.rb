class BuildingListDecorator < ResourceDecorator
  delegate_all

  class << self
    def column_names
      %w(look name)
    end
  end

end
