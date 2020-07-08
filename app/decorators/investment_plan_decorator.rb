class InvestmentPlanDecorator < ResourceDecorator

  class << self
    def column_names
      %w(look real_estate_project)
    end
  end

end
