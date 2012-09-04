require 'test_helper'

class ShangjidingzhisControllerTest < ActionController::TestCase
  setup do
    @shangjidingzhi = shangjidingzhis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shangjidingzhis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shangjidingzhi" do
    assert_difference('Shangjidingzhi.count') do
      post :create, shangjidingzhi: @shangjidingzhi.attributes
    end

    assert_redirected_to shangjidingzhi_path(assigns(:shangjidingzhi))
  end

  test "should show shangjidingzhi" do
    get :show, id: @shangjidingzhi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shangjidingzhi
    assert_response :success
  end

  test "should update shangjidingzhi" do
    put :update, id: @shangjidingzhi, shangjidingzhi: @shangjidingzhi.attributes
    assert_redirected_to shangjidingzhi_path(assigns(:shangjidingzhi))
  end

  test "should destroy shangjidingzhi" do
    assert_difference('Shangjidingzhi.count', -1) do
      delete :destroy, id: @shangjidingzhi
    end

    assert_redirected_to shangjidingzhis_path
  end
end
