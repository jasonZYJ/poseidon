class EnhancedSelectInput < ::SimpleForm::Inputs::CollectionSelectInput
  def input(*args)
    collection_field << javascript
  end

  protected

  def collection_field
    @collection_field ||= begin
      label_method, value_method = detect_collection_methods

      @builder.collection_select(
        attribute_name, collection, value_method, label_method,
        input_options, input_html_options
      )
    end
  end

  def collection_field_id
    collection_field.match(/id=\"([^\"]+)\"/).captures.first
  end

  def javascript
    template.javascript_tag(<<-JS.html_safe)
      (function() {
        var input = $('select\##{collection_field_id}');

        input.select2(#{ActiveSupport::JSON.encode(js_options.stringify_keys)});
      })();
    JS
  end

  def js_options
    {
      :placeholder => placeholder.to_s,
      :width => input_options[:width] || 'resolve',
      :allowClear => input_options[:include_blank]
    }
  end
end
