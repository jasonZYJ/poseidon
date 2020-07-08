module CommonDecorations
  extend ActiveSupport::Concern

  def with_icon(method, icon=nil)
    if (v = source.send(method)).present?
      h.content_tag(:div) do
        [h.send("#{icon || method}_icon"), v].join(' ').html_safe
      end
    end
  end


  def date(method_name)
    resource.send(method_name).strftime("%d %b %Y")
  end

  def time_ago(method_name)
    v = resource.send(method_name)
    "#{h.time_ago_in_words(v)} ago" if v.present?
  end

  def value
    currency(:value)
  end

  def area(method_name, *args)
    h.number_with_precision(resource.send(method_name,*args),precision: 2, delimiter: ',')
  end

  def currency(method_name, *args)
#    h.number_to_currency(resource.send(method_name))
    format_currency(resource.send(method_name, *args))
  end

  def format_currency number
    h.number_with_precision(number, :precision => 2, :delimiter => ',' )
  end

  def boolean(method_name)
    h.send("#{resource.send(method_name)}_icon")
  end

  def look
    h.link_to h.look_icon, h.with_nesting(resource)
  end

  def edit
    h.link_to h.edit_icon, [:edit, h.with_nesting(resource)].flatten, remote: true if resource.id.present?
  end

  def delete
    h.link_to h.trash_icon, h.with_nesting(resource),method: :delete
  end

  def to_s
    resource.to_s
  end

  def percentage(method_name)
    h.number_to_percentage (resource.send method_name),precision: 2
  end

end
