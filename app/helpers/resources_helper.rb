module ResourcesHelper

  def simple_form_for(object, options={}, &block)
    options.reverse_merge!  :builder => builder,
                            :url => options[:url] || create_or_update_resource_path(object, options[:without_nesting])

    super(object, options, &block)
  end

  def builder
    builder_class_for(resource_class.name)
  end

  def builder_class_for(name)
    "#{name}FormBuilder".constantize

  rescue NameError => e
    default_builder
  end

  def create_or_update_resource_path(object, without_nesting=false)
    unless object.persisted?
      collection_path
    else
      without_nesting ? object : resource_path(object)
    end
  end

  def cell_classes column
    ["cell", column, resource.try(:clickable_row?) ? "clickable" : nil].compact.join(' ')
  end

  def resource_cell_link resource
    resource_path(resource) if resource.try(:clickable_row?)
  end

  def form_element_names
    decorator_class.form_element_names
  end

  def form_column_names
    decorator_class.form_column_names
  end

  def default_builder
    FormBuilder
  end

  def new_resource_action(*args)
    options = args.extract_options!
    path, klass = args

    options.reverse_merge! :class => 'bg-success', :remote => true

    content_tag(:li) do
      link_to((path || new_resource_path), options) do
        content_tag(:span, new_resource_action_text(klass||resource_class), :class => 'menu-text')
      end
    end
  end

  def new_resource_action_text(klass = resource_class)
    object_name = klass.name.underscore

    translate("helpers.button.#{object_name}.new",
              :model => human(klass),
              :default => [
                  :'helpers.button.new',
                  human(klass)
              ]).titleize
  end

  def human(model)
    model.model_name.human
  end

  def human_attrs(model, attrs_nonhuman)
    attrs_nonhuman.map { |a| human_attr(model, a) }
  end

  def human_attr(model, attr_nonhuman)
    model.human_attribute_name(attr_nonhuman.to_sym)
  end

  def form_heading(action)
    t("form.#{resource_class.name.underscore}.heading.#{action.to_s}",
      :default => "New #{resource_class.model_name.human.titleize}"
    )
  end

  def tooltip(options, &block)
    content_tag(:span, options.reverse_merge('data-toggle' => :tooltip), &block)
  end

end
