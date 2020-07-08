module Mergable
  extend ActiveSupport::Concern
  include Reflections
  include SoftDeletable

  def merge_attribute(attr, source)
    case attr.class.name
      when NilClass.name
        source
      when BigDecimal.name
        attr + (source || 0)
      when String.name
        attr + '_'+ (source.to_s)
      when Fixnum.name
        attr + (source.to_i)
      when Float.name
        attr + (source.to_f)
      else
        raise 'Unsupported Class Type'
    end
  end
end
