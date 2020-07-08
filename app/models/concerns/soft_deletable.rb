module SoftDeletable
  extend ActiveSupport::Concern

  included do
    default_scope { where(:is_deleted => false) }

    alias_method :destroy!, :destroy
    alias_method :delete!, :delete

    before_destroy :rename
  end

  def destroy
    run_callbacks(:destroy) do
      soft_delete unless errors.any?
    end
  end

  def delete
    soft_delete unless new_record?
  end

  def name_unique?
    false
  end

  def name_column
    :name
  end

  protected

  def rename
    assign_attributes(name_column => "#{send(name_column)} - DELETED") if name_unique?
  end

  def soft_delete
    update_attributes!(:is_deleted => true)
  end
end
