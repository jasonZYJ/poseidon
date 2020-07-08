module InlineInputs
  class Text < Base
    def config
      super.merge({
                      :type => 'text',
                      :tpl => tpl
                  })
    end

    protected

    def tpl
      "<input type=\"text\" #{maxLength}>"
    end

    def maxLength
      "maxLength=#{self.options[:maxLength]}" if self.options[:maxLength]
    end
  end
end