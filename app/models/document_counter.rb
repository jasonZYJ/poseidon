class DocumentCounter < Poseidon::ActiveRecord

  belongs_to :organisation

  validates :organisation, :presence => true

  class << self
    def next_number(organisation, document)
      return unless organisation && document

      transaction do
        dc = instance(organisation, document)

        dc.with_lock do
          dc.increment!(:counter)
        end

        dc.counter
      end
    end

    def instance(organisation, document)
      first_or_create(organisation: organisation, document_type: document.counter_class_name)
    end
  end
end
