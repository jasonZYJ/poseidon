module InlineInputs
  class Boolean < Base
    def config
      # X-editable doesn't support booleans out of the box, this is the suggested way to represent them
      super.merge({
                      :type => 'select',
                      :source => [{value: 1, text: I18n.t(:yes)}, {value: 0, text: I18n.t(:no)}],
                      :value => resource.send(attr_name) ? 1 : 0
                  })
    end
  end
end