class Household < ApplicationRecord
  has_many :users
  has_many :invitations
  belongs_to :user, :class_name => 'User' # households table has user_id
end
