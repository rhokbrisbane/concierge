class User < ActiveRecord::Base
  include HasApiToken
  include Sharable
  include Taggable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_and_belongs_to_many :groups, join_table: :user_groups

  has_one :address, as: :addressable, dependent: :destroy

  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_many :resources
  has_many :guardianships, dependent: :destroy
  has_many :kids, through: :guardianships
  has_many :comments

  has_many :saved_searches

  accepts_nested_attributes_for :address

  def comments_as_subject
    Comment.where(commentable_type: 'User', commentable_id: id)
  end

  def to_s
    name.presence || email.presence || "User#{id}"
  end

  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      unless user.persisted?
        user.provider  = auth.provider
        user.uid       = auth.uid
        user.email     = auth.info.email
        user.password  = Devise.friendly_token[0, 20]
        user.name      = auth.info.name
        user.image_url = auth.info.image
        user.save!
      end
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end
end
