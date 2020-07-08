module Importable
  extend ActiveSupport::Concern

  require 'qiniu_helper'
  include QiniuHelper
  require 'roo'

  included do
    has_attached_file :attachment, attachment_params('shop_attachments/:id/:filename')

    ALLOW_IMPORT_MIME_TYPES = %w(application/excel application/vnd.ms-excel application/vnd.msexcel application/octet-stream application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)

    validates_attachment_size :attachment, less_than: 10.megabytes, message: "The import file cannot exceed 10 MB in size"
    validates_attachment_content_type :attachment, content_type: ALLOW_IMPORT_MIME_TYPES, message: "This type of file is not allowed. Please upload excel file(xls or xlsx)."

    attr_accessor :import_errors, :import_result_filename
  end


  def import!
    self.import_errors = []
    begin
      self.update_attributes!(status: 'processing')
      file = attachment.path
      raise "Please provide a file." unless file
      rows = handle_rows(parse_excel(self.qiniu_object_url(file)))
      self.import_errors << mapping_columns + ["Failure Reason"]
      rows.each do |row|
        handle_columns(row)
        obj = build_data(mapping_data(row), self.organisation_id, extra_options(rows))
        errors = save_object(obj)
        self.import_errors << (row << errors.join(", ")) if errors.any?
      end
    rescue Exception => e
      Rails.logger.error("Exception: #{e.message}\n#{e.backtrace.join('/n')}")
      self.import_errors << [e.message]
    ensure
      self.update_attributes!(status: self.import_errors.size > 1 ? 'failed' : 'processed')
    end
    #TODO write_import_error_report
  end

  def parse_excel file_url
    rows = []
    Roo::Excelx.new(file_url).each { |row| rows << row.map(&:to_s) }
    rows
  end

  def mapping_data(row)
    mapping_columns.map(&:to_sym).zip(row).to_h
  end

  def field_empty? field
    field.nil? || field.try(:strip).try(:empty?)
  end

  def save_object (objects)
    errors = collate_import_row_errors(objects)
    if errors.empty?
      begin
        ActiveRecord::Base.transaction do
          objects.each(&:save!)
        end
      rescue Exception => e
        errors.push(e.message)
      end
    end
    errors
  end

  def collate_import_row_errors (objects)
    e = self.errors.full_messages + objects.map { |x| x.errors.full_messages }.flatten
    self.errors.clear
    e
  end

end