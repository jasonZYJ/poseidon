class Contact < Poseidon::ActiveRecord
  belongs_to :organisation, required: true

  def to_s
    full_name
  end
end
