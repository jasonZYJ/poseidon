module ShopImportsHelper
  def import_button
    link_to(t(:import), new_shop_import_path, remote: true, class: 'btn btn-success btn-lg active', role: 'button')
  end
end
