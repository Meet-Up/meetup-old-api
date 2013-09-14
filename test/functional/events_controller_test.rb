require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  def setup
    @controller = EventsController.new
    @event = events(:one)
    @user = users(:one)
  end

  def teardown
    @event = nil
    @user = nil
  end

  test "should get create" do
    get :create, token: @user.token, event: { name: "foo" }
    assert_response :success
  end

  test "should get show" do
    get :show, id: @event.id
    assert_response :success
  end

end
