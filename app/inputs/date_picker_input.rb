class DatePickerInput < SimpleForm::Inputs::DateTimeInput
  def input(*args)
    text_field  << javascript
  end

  def input_html_options
    super.tap do |h|
      (h[:data] ||= {}).merge!(:handle => handle)
      h[:class] = (h[:class] || '') << ' search_query form-control'
    end
  end

  protected

  def date_select
    p attribute_name
    @builder.send(:date_select, attribute_name, input_options,
                  input_html_options.except(:data))
  end

  def text_field
    @builder.send(:text_field, attribute_name, input_html_options)
  end

  def handle
    @_handle ||=
     [ self.class.name.underscore.dasherize,
       (Time.now.to_i + rand(255)).to_s(36) ].join('-')
  end

  def javascript
    template.javascript_tag(<<-JS.html_safe)
      $(function() {
        var input = $("input[data-handle='#{handle}']");
        input.siblings(":input").remove().end()
             .show()
             .datepicker({
               format: "yyyy-mm-dd",
               weekStart: 1,
               autoclose: true
             });
      });
    JS
  end
end
