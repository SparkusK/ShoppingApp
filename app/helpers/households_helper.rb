module HouseholdsHelper

  # Returns boolean whether the user belongs to any household or not.
  def belongs_to_household?
    !current_user.household.nil?
  end

end
