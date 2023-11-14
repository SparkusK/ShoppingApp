require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "Shopping App" # app/helpers/application_helper.rb, full_title
    assert_equal full_title("Help"), "Help | Shopping App" # same as above
  end
end
