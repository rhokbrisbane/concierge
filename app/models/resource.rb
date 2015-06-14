class Resource < ActiveRecord::Base
  extend EnumerateIt

  include Sharable
  include Taggable
  include Commentable

  belongs_to :user
  belongs_to :resource_category

  has_one :address, as: :addressable, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true

  has_enumeration_for :region

  has_attached_file :avatar, styles: { thumb: '100x100>' }

  accepts_nested_attributes_for :address

  def to_s
    name
  end

  def to_h
    {
      id:      id,
      url:     url,
      phone:   phone,
      type:    self.class.name.underscore,
      address: address.to_h
    }
  end
end
