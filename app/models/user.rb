class User < Poseidon::ActiveRecord
  include Nameable
  include Authorized
  include Restricted

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organisation
  has_many :role_users
  has_many :roles, through: :role_users
  has_many :permissions, through: :roles
  has_many :visitations, foreign_key: :creator_id
  has_many :agreements, foreign_key: :creator_id
  has_many :responsible_agreements, foreign_key: :responsible_person_id
  has_many :leases, foreign_key: :creator_id
  has_many :responsible_leases, foreign_key: :responsible_person_id

  alias_attribute :admin?, :is_administrator?

  before_validation :set_name

  def set_name
    self.name ||= email
  end

end
