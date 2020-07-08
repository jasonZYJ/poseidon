class PercentageInput < ::SimpleForm::Inputs::NumericInput

  def input(*args)
    content_tag(:div, super(class: 'form-control') << content_tag(:span,'%',class: 'input-group-addon'), class: 'input-group')
  end

end
