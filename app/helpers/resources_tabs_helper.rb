module ResourcesTabsHelper
  def tabs(resource)
    resource.present? ? render_resource_tabs(resource) : render_collection_tabs
  end

  def render_resource_tabs(resource)
    resource.class.ancestors.map(&:name).compact.each do |n|
      begin
        return render(tabs_location(n), :locals => { :resource => resource })
      rescue ActionView::MissingTemplate => e
      end
    end
    nil
  end

  def tabs_location(name)
    "#{name.underscore.pluralize}/tabs"
  end

  def render_collection_tabs
    resource_class.ancestors.map(&:name).compact.each do |n|
      begin
        return render(collection_tabs_location(n))
      rescue ActionView::MissingTemplate => e
      end
    end
    nil
  end

  def collection_tabs_location(name)
    "#{name.underscore.pluralize}/index_tabs"
  end

  def tab_to(*args, &block)
    options = args.extract_options!
    options[:class] =
      current_page?(*(block_given? ? args : (args.drop(1)))) ? "active" : nil

    content_tag(:li, link_to(*args << options, &block), options)
  end
end
