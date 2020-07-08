class CommissionFormBuilder < FormBuilder

  def proportion
    input :proportion, as: :percentage
  end

end
