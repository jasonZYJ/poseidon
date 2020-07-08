module InlineInputs
  class Base
    attr_accessor :resource,
                  :attr_name,
                  :template,
                  :options

    def initialize(resource, attr_name, template, options={})
      self.resource = resource
      self.attr_name = attr_name
      self.template = template
      self.options = options
    end

    def config
      self.options.reverse_merge!({
                                      :behaviour => :editable,
                                      :name => attr_name,
                                      :mode => 'inline',
                                      :pk => resource.id,
                                      :'original-title' => "Edit #{attr_name.to_s.humanize}"
                                  })
    end

    def javascript

    end
  end
end
