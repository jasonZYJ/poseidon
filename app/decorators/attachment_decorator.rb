class AttachmentDecorator < ResourceDecorator
  require 'qiniu_helper'
  include QiniuHelper

  class << self
    def column_names
      %w(file_name caption)
    end

    def form_element_names
      %w(file caption)
    end
  end

  def file_name
     h.link_to(resource.file_file_name,  qiniu_object_url(resource.file.path))
  end

end
