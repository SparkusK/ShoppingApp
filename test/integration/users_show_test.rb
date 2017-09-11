require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @activated = users(:herp)
    @non_activated = users(:george)
  end

  test "should not show non-activated user" do
    log_in_as(@activated)
    assert is_logged_in?
    assert_not @non_activated.activated
    get user_path(@non_activated)
    assert_redirected_to root_url
  end

  test "should show activated user" do
    log_in_as(@activated)
    assert is_logged_in?
    assert @activated.activated
    get user_path(@activated)
    assert_template 'users/show'
  end


end
