module Exportable
  extend ActiveSupport::Concern

  def export
    respond_to do |format|
      format.html { send_attachment_data excel_content_for(resource_class.generate_excel), "#{resource_class.to_s.underscore.pluralize}_#{Time.now.strftime("%Y%m%d%H%M%S")}.xlsx" }
    end
  end

  protected

  def excel_content_for objs
    work_book = RubyXL::Workbook.new
    objs.each_with_index do |obj, index|
      (0..obj.size).each {|r| work_book[0].add_cell(index, r, obj[r])}
    end
    work_book.stream.string
  end

end






