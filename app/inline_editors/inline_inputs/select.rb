module InlineInputs
  class Select < Base
    def config
      super.merge({:type => 'select'})
    end
  end
end