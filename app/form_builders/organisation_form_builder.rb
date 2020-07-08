class OrganisationFormBuilder < FormBuilder

  def legal_representative
    association :legal_representative, collection: Contact.all.order(:full_name)
  end
end
