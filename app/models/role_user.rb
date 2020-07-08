class RoleUser < Poseidon::ActiveRecord
  belongs_to :role, required: true
  belongs_to :user, required: true
end
