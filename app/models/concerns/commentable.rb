module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments,
             -> { recent },
             class_name: 'Comment',
             as: :commentable,
             dependent: :destroy
    has_many :public_comments,
             -> { recent.is_public },
             class_name: 'Comment',
             as: :commentable
  end
end
