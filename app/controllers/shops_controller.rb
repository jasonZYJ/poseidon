class ShopsController < ResourcesController
  load_and_authorize_resource

  include ApplicationHelper
  include Exportable

  def show
    redirect_to [resource, :agreements]
  end

  def merge
    shops =  resource_class.where(id: params[:ids])
    shops.inject(shops.first.copy){|s, v| s.merge(v)}.tap do |c|
      c.children << shops
      c.consolidated = true
    end.save!
    render :index
  end

  def split
    resource.split.delete
    redirect_to collection_path
  end

  def collection
    memoize_collection do
      super.unmerged
    end
  end
  
  protected
  def permitted_params
    super | %w(sub_category_id type_id workflow_id)
  end

end
