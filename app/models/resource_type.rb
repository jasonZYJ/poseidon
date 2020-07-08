class ResourceType < Poseidon::ActiveRecord
  self.inheritance_column = nil
  has_many :permissions

  def to_s
    type
  end
end
