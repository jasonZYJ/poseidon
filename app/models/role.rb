class Role < Poseidon::ActiveRecord
  include Nameable
  include Restricted

  belongs_to :owner, class_name: 'Organisation', required: true
  has_many :role_users
  has_many :users, through: :role_users
  has_many :permissions

  alias_attribute :organisation, :owner

end
