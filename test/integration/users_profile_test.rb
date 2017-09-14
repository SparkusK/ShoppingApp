require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:herp)
  end

  test "profile display" do
    assert true
    # Need to rewrite this test.
  end
end
