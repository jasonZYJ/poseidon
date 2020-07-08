class ContractDecorator < ResourceDecorator
  delegate_all

  class << self
    def column_names
      %w(name unit_cost delete)
    end
  end
end
