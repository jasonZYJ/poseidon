class ContactDecorator < ResourceDecorator

  class << self
    def column_names
      super | %w(legal_representative)
    end
  end

end
