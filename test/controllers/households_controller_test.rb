require 'test_helper'

class HouseholdsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @household = households(:one)
    @head = users(:herp)
  end

  test "should get index" do
    # Assert that the user is logged in
    get households_url
    assert_response :success
  end

  test "should get new" do
    get new_household_url
    assert_response :success
  end

  test "should create household" do
    @new_household = Household.new(name: @head.name, user_id: @head.id)
    assert_difference('Household.count') do
      post households_url, params: { household: { name: @new_household.name, user_id:  @new_household.user_id } }
    end
    # Need to assert that the user who requested the household creation is now:
    # * Part of the household, and
    # * the head of the household
  end

  test "should show household" do
    # Need to assert that the user is a part of the household
    get household_url(@household)
    assert_response :success
  end

  test "should get edit" do
    # Need to assert that the head is requesting the edit page.
    get edit_household_url(@household)
    assert_response :success
  end

  test "should update household" do
    # Need to assert that the changes are coming from the head of the household
    patch household_url(@household), params: { household: { user_id: @head.id } }
    assert_redirected_to household_url(@household)
  end


  test "should destroy household" do
    # need to assert that:
    # * the user is logged in,
    # * the user belongs to the household,
    # * and the user is the head of the household
    assert_difference('Household.count', -1) do
      delete household_url(@household)
    end

    assert_redirected_to households_url
  end

  test "should redirect to home if not logged in" do

  end

  test "should redirect to user profile if the user doesn't belong to the household" do

  end


end
