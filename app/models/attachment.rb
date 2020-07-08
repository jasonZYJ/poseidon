require 'qiniu_helper'
class Attachment < Poseidon::ActiveRecord
  include QiniuHelper

  has_attached_file :file, attachment_params('attachments/:id/:filename')

  validates_attachment :file,
                       :size => {:greater_than => 0.0000001.megabytes, :less_than => 10.megabytes},
                       :content_type => {:content_type => Proc.new { self.valid_file_content_types }}

  belongs_to :context, :polymorphic => true, :counter_cache => true, required: true
  audited associated_with: :context

  class << self
    def valid_file_content_types
      %w(
      application/msword
      application/vnd.msword
      application/vnd.openxmlformats-officedocument.wordprocessingml.document
      application/pdf
      text/pdf
      application/vnd.ms-excel
      application/excel
      application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
      text/comma-separated-values
      text/csv
      application/csv
      image/png
      image/jpeg
      text/rtf
      image/gif
      text/plain
      application/zip
      image/tiff
      image/bmp
      application/mspowerpoint
      application/vnd.ms-powerpoint
      application/vnd.openxmlformats-officedocument.presentationml.presentation
    )
    end

    def private?
      false
    end
  end

  def to_s
    caption
  end
end
