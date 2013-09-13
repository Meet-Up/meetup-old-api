require 'test_helper'

class PossibleDatesControllerTest < ActionController::TestCase
  def setup
    @controller = PossibleDatesController.new
    @possible_date = possible_dates(:one)
  end

  def teardown
    @possible_date = nil
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get show" do
    get :show, id: @possible_date.id
    assert_response :success
  end

end
