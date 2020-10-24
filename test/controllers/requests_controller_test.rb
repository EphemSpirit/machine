require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest

  test "creating a friend request requires a logged in user" do
    assert_no_difference 'Request.count' do
      post requests_path
    end
  end
end
