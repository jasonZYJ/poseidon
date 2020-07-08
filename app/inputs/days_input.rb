class DaysInput < ::SimpleForm::Inputs::StringInput

  def input(*args)
    content_tag(:div, super(class: 'form-control') << content_tag(:span,"#{t('days')}",class: 'input-group-addon'), class: 'input-group')
  end

end
