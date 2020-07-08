module InlineInputs
  class Textarea < Base
    def config
      super.merge({:type => 'textarea'})
    end
  end
end