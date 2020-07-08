class Organisation < Poseidon::ActiveRecord
  include Nameable
  include Restricted
  
  belongs_to :parent, class_name: 'Organisation'
  has_many :users
  has_many :leases, foreign_key: :first_party_id
  has_many :shops
  has_many :agreements, foreign_key: :first_party_id
  has_many :contacts

end
