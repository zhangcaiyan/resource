require 'test_helper'

class JiagesControllerTest < ActionController::TestCase
  setup do
    @jiage = jiages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jiages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jiage" do
    assert_difference('Jiage.count') do
      post :create, jiage: @jiage.attributes
    end

    assert_redirected_to jiage_path(assigns(:jiage))
  end

  test "should show jiage" do
    get :show, id: @jiage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jiage
    assert_response :success
  end

  test "should update jiage" do
    put :update, id: @jiage, jiage: @jiage.attributes
    assert_redirected_to jiage_path(assigns(:jiage))
  end

  test "should destroy jiage" do
    assert_difference('Jiage.count', -1) do
      delete :destroy, id: @jiage
    end

    assert_redirected_to jiages_path
  end
end
