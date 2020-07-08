module Contractual
  extend ActiveSupport::Concern
  include Commentable
  include Numberable
  include Loggable
  include Restricted

  included do
    audited

    belongs_to :first_party,class_name: 'Organisation', required: true
    belongs_to :second_party,class_name: 'Organisation', required: true
    belongs_to :creator, class_name: 'User', required: true
    belongs_to :responsible_person, class_name: 'User', required: true
    has_many :visitations, as: :context
    has_many :attachments, as: :context

    has_associated_audits

  end

  def date_range
    if start_date > end_date
      errors.add(:base, 'Start Date should not be after End Date')
    end
  end
end
