module ResourcesInlineEditorHelper

  def inline_editor_for(resource, template)
    inline_editor_class_for(resource.class.name).new(resource, editable_link_resource(resource), editable_link_url(resource), template)
  end

  def inline_editor_class_for(name)
    "#{name}InlineEditor".constantize

  rescue NameError => e
    default_inline_editor
  end

  def default_inline_editor
    ResourceInlineEditor
  end

  def editable_link_resource(resource)
    resource == outer ? resource.class.name.demodulize.underscore : resource_params_name
  end

  def editable_link_url(resource)
    resource == outer ? polymorphic_url(nest_to(resource.class.name.demodulize.underscore)) : resource_path(resource)
  end

end
