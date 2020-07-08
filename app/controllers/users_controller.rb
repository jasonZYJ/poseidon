class UsersController < ResourcesController

  def show
    redirect_to [resource, :visitations]
  end

  def activities_counts
    respond_to do |format|
      format.json {render :json => {contact_brands_count: [my_contacts_count,total_visitations_count],
                                    agreement_shops_count: [my_agreement_shops_count, total_agreement_shops_count],
                                    agreement_brands_count: [my_agreement_brands_count, total_agreement_brands_count],
                                    lease_shops_count: [my_leased_shops_count, total_leased_shops_count],
                                    lease_brands_count: [my_leased_brands_count, total_leased_brands_count],
                                    lease_amounts_count:[my_leases_amount,total_leases_amount]}}
    end
  end


  def my_contacts_count
    resource.visitations.map(&:contact).uniq.count
  end

  def total_visitations_count
    resource.visitations.count
  end

  def my_leased_shops_count
    resource.leases.map(&:shop).uniq.count
  end

  def total_leased_shops_count
    current_organisation.leases.map(&:shop).uniq.count
  end

  def my_leased_brands_count
    resource.leases.map(&:brand).uniq.count
  end

  def total_leased_brands_count
    current_organisation.leases.map(&:brand).uniq.count
  end

  def my_agreement_shops_count
    resource.agreements.map(&:shop).uniq.count
  end

  def total_agreement_shops_count
    current_organisation.agreements.map(&:shop).uniq.count
  end

  def my_agreement_brands_count
    resource.agreements.map(&:brand).uniq.count
  end

  def total_agreement_brands_count
    current_organisation.agreements.map(&:brand).uniq.count
  end

  def my_leases_amount
    resource.leases.map(&:total_value).compact.sum
  end

  def total_leases_amount
    current_organisation.leases.map(&:total_value).compact.sum
  end

  protected
  def permitted_params
    super | %w(organisation_id)
  end

end
