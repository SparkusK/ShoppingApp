class Household < ApplicationRecord
  has_many :users
  belongs_to :user, :class_name => 'User' # households table has head_id
end
