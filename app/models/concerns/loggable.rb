module Loggable
  extend ActiveSupport::Concern

  included do
    attr_accessor :context_changes

    has_many :activities, ->(object) { for_resource_class(object.class) }, foreign_key: :context_id

    before_update :log_changes
  end

  def activity_delta
    delta_attributes.reject { |k, v| activity_delta_blacklist.include?(k) }.symbolize_keys
  end

  def activity_delta_blacklist
    %w(id created_at updated_at search_text lock_version)
  end

  protected

  def delta_attributes
    context_changes.present? ? attributes.merge({context_changes: context_changes}) : attributes
  end

  def log_changes
    self.context_changes = changes.reject { |k, v| activity_delta_blacklist.include?(k) }
  end
end
