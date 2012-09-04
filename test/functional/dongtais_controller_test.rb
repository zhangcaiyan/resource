require 'test_helper'

class DongtaisControllerTest < ActionController::TestCase
  setup do
    @dongtai = dongtais(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dongtais)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dongtai" do
    assert_difference('Dongtai.count') do
      post :create, dongtai: @dongtai.attributes
    end

    assert_redirected_to dongtai_path(assigns(:dongtai))
  end

  test "should show dongtai" do
    get :show, id: @dongtai
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dongtai
    assert_response :success
  end

  test "should update dongtai" do
    put :update, id: @dongtai, dongtai: @dongtai.attributes
    assert_redirected_to dongtai_path(assigns(:dongtai))
  end

  test "should destroy dongtai" do
    assert_difference('Dongtai.count', -1) do
      delete :destroy, id: @dongtai
    end

    assert_redirected_to dongtais_path
  end
end
