require 'test_helper'

class HangqingsControllerTest < ActionController::TestCase
  setup do
    @hangqing = hangqings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hangqings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hangqing" do
    assert_difference('Hangqing.count') do
      post :create, hangqing: @hangqing.attributes
    end

    assert_redirected_to hangqing_path(assigns(:hangqing))
  end

  test "should show hangqing" do
    get :show, id: @hangqing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hangqing
    assert_response :success
  end

  test "should update hangqing" do
    put :update, id: @hangqing, hangqing: @hangqing.attributes
    assert_redirected_to hangqing_path(assigns(:hangqing))
  end

  test "should destroy hangqing" do
    assert_difference('Hangqing.count', -1) do
      delete :destroy, id: @hangqing
    end

    assert_redirected_to hangqings_path
  end
end
