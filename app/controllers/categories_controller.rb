class CategoriesController < ResourcesController

  def show
    redirect_to [resource, :sub_categories]
  end

end