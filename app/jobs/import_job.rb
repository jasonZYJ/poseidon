class ImportJob < ActiveJob::Base
  queue_as :default

  def perform(shop_import_id)
    s = ShopImport.where(id: shop_import_id).first
    s.import!
  end
end