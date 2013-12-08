module Sharable
  extend ActiveSupport::Concern

  included do
    has_many :user_shares, as: :sharable
    has_many :shared_users, through: :user_shares

    has_many :group_shares, as: :sharable
    has_many :shared_groups, through: :group_shares
  end
end
