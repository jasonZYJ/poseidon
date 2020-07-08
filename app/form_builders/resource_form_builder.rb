class ResourceFormBuilder < SimpleForm::FormBuilder

  attr_accessor :as_row_form

  def just_some_text(key)
    template.label_tag t(key)
  end

  def t(key)
    template.t("form.#{object.class.name.underscore}.#{key}")
  end

  def association(*args)
  	options = args.extract_options!

		super(args.first,
      {
        :as => :enhanced_select,
        :placeholder => "#{I18n.t(:select)}#{object.class.human_attribute_name(args.first)}",
        :label_method => :to_s,
        :required => true,
        :include_blank => true
      }.merge(options)
	  )
  end


  def save
    submit :class => 'btn btn-xs btn-info submit'
  end

  def actions
    template.render :partial => 'form_actions',
                    :locals => { :f => self }
  end

  def deletable?
    object.persisted?
  end

  def input(*args)
    as_row_form ? input_field(*args) : super
  end

  def start_date
    input :start_date, as: :date_picker
  end

  def end_date
    input :end_date, as: :date_picker
  end

  def method_missing(method, *args, &block)
    if object.respond_to?(method)
      input method
    else
      super
    end
  end
end
