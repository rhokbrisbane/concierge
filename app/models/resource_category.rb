class ResourceCategory < ActiveRecord::Base
  validates :name, presence: true

  has_many :resources

  def to_s
    name
  end
end
