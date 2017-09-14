require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:herp)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {
      user: {
        firstname: "", # empty
        surname: "", # empty
        email: "foo@invalid", # needs *.com
        password: "foo", # too short
        password_confirmation: "bar" #too short, doesn't match
      }
    }
    assert_template 'users/edit'
    assert_select "div.alert", "The form contains 5 errors."
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Valid Name"
    email = "valid@email.com"
    patch user_path(@user), params: {
      user: {
        firstname: name,
        email: email,
        password: "validp",
        password_confirmation: "validp"
      }
    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.firstname
    assert_equal email, @user.email
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: {
      user: {
        firstname: name,
        email: email,
        password: "",
        password_confirmation: ""
      }
    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.firstname
    assert_equal email, @user.email
  end

  test "friendly forwarding should revert to default redirect url" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    assert session[:forwarding_url].nil?

  end
end
