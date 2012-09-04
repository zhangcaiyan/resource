require 'test_helper'

class CompanyPricesControllerTest < ActionController::TestCase
  setup do
    @company_price = company_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:company_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company_price" do
    assert_difference('CompanyPrice.count') do
      post :create, company_price: @company_price.attributes
    end

    assert_redirected_to company_price_path(assigns(:company_price))
  end

  test "should show company_price" do
    get :show, id: @company_price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @company_price
    assert_response :success
  end

  test "should update company_price" do
    put :update, id: @company_price, company_price: @company_price.attributes
    assert_redirected_to company_price_path(assigns(:company_price))
  end

  test "should destroy company_price" do
    assert_difference('CompanyPrice.count', -1) do
      delete :destroy, id: @company_price
    end

    assert_redirected_to company_prices_path
  end
end
