class Comment < Poseidon::ActiveRecord

  attr_accessor :current_user

  belongs_to :commentable, :polymorphic => true, :counter_cache => true
  belongs_to :creator, class_name: 'User', required: true

  audited associated_with: :commentable

  scope :created_by,  -> (user) { where(:creator_id => user.context.id) }
  scope :recent,      -> { order(arel_table[:created_at].desc) }
  scope :is_public,   -> { where(private: false) }
  scope :is_private,  -> { where(private: true) }

  validates :body, presence: true

end
