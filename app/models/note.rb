class Note < ActiveRecord::Base
  belongs_to :user

  validates :title, :content, :user_id, presence: true
end

