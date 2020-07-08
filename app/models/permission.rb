class Permission < Poseidon::ActiveRecord
  belongs_to :role, required: true

  def to_s
    "#{role}_#{resource_type}"
  end

end
