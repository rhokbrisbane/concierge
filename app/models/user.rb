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

  def to_s
    name.presence || email.presence || "User#{id}"
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
    User.where(provider: auth.provider, uid: auth.uid).first || User.create({
      name:        auth.extra.raw_info.name,
      provider:    auth.provider,
      uid:         auth.uid,
      email:       auth.info.email,
      image_url:   auth.info.image,
      password:    Devise.friendly_token[0,20]
    })
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end
end
