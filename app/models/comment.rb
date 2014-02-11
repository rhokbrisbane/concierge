class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :user_id, :commentable_id, :commentable_type, :content, presence: true

  validates :commentable_type, inclusion: { in: %w(Resource Tag User) }

  default_scope ->{ order('created_at ASC') }
end

