module Responding
  extend ActiveSupport::Concern

  included do
	  responders :flash, :http_cache
    respond_to :json, :js, :html
	end
  
  protected

  def interpolation_options
    { 
    	resource_type: resource_class.model_name.human,
    	resource_name: resource.to_s
    }
  end
end