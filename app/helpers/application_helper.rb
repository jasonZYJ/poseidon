module ApplicationHelper
  include IconsHelper

  def human(model)
    model.model_name.human
  end

  def send_attachment_data content, filename
    send_data(content, :type => "text/excel;charset=utf-8; header=present", :filename => filename, :disposition => 'attachment')
  end

  def sidebar_feature_resources
    [Category, Brand, ShopType] | restricted_resources.keep_if{|r| can? :read, r }
  end

  def restricted_resources
    Poseidon::ActiveRecord.restricted_resources
  end
end
