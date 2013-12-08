class Note < ActiveRecord::Base
  include Sharable

  belongs_to :user

  validates :title, :content, :user_id, presence: true
end

