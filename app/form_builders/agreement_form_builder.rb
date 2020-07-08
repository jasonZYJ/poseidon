class AgreementFormBuilder < FormBuilder

  def responsible_person
    association :responsible_person, collection: User.all.order(:name), include_blank: true
  end

  def management_type
    input :management_type, collection: ['直营','加盟','独立经营']
  end
end
