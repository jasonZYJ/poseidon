module InlineInputs
  class Combodate < Base
    def config
      super.merge({
                      :type => 'combodate',
                      :mode => 'popup',
                      :combodate => {
                          :smartDays => true,
                          :maxYear => Date.current.year + 10
                      }
                  })
    end
  end
end