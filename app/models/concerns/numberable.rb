module Numberable
  extend ActiveSupport::Concern

  included do
    before_validation :assign_number
    validate :number_field_present
    validate :number_field_length
  end

  def assign_number
    if number.blank?
      num = DocumentCounter.next_number(owner, self)
      unless num
        errors.add(number_method, 'cannot be generated')
        raise "Unable to generate a new document number for owner_id #{owner.try(:id)}."
      end
      self.number = ("#{number_prefix}#{'%05d' % num}")
    end
  end

  def counter_class_name
    self.class.name.demodulize
  end

  def number
    send(number_method)
  end

  def number=(integer)
    send("#{number_method}=", integer)
  end

  def to_s
    number
  end

  protected

  def number_method
    "#{counter_class_name.underscore}_number"
  end

  def number_field_present
    errors.add(number_method, 'cannot be empty') if number.blank?
  end

  def number_field_length
    errors.add(number_method, 'is too long') if number.to_s.length > 255
  end

  def number_prefix
    raise 'must implement in the model!'
  end

end
