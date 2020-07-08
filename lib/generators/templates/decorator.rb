<% module_namespacing do -%>
class <%= class_name %>Decorator < ResourceDecorator

  class <<  self
    def column_names
      super
    end
  end
end
<% end -%>
