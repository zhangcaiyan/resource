# coding: utf-8

class CompanyPricesController < ApplicationController

  before_filter :authenticate_user!, except: [:show]

  layout "admin", except: [:show]

  # GET /company_prices
  # GET /company_prices.json
  def index
    @search = current_user.company_prices.search(params[:search])
    @company_prices = @search.page(params[:page]).per_page(21).order("created_at DESC")
  end

  # GET /company_prices/1
  # GET /company_prices/1.json
  def show
    @company_price = CompanyPrice.find(params[:id])
    @company_prices = @company_price.user.company_prices.order("created_at DESC") 
    @other_company_prices = CompanyPrice.where("category1_id = ? AND user_id != ?", @company_price.category1_id, @company_price.user_id).order("created_at DESC").limit(6)
    @new_company_prices = CompanyPrice.order("created_at DESC").limit(8)
  end

  # GET /company_prices/new
  # GET /company_prices/new.json
  def new
    @company_price = current_user.company_prices.new
  end

  # GET /company_prices/1/edit
  def edit
    @company_price = current_user.company_prices.find(params[:id])
  end

  # POST /company_prices
  # POST /company_prices.json
  def create
    @company_price = current_user.company_prices.new(params[:company_price])
    if @company_price.save
      redirect_to company_prices_path, notice: '报价信息发布成功'
    else
      render action: "new"
    end
  end

  # PUT /company_prices/1
  # PUT /company_prices/1.json
  def update
    @company_price = current_user.company_prices.find(params[:id])

    if @company_price.update_attributes(params[:company_price])
      redirect_to company_prices_path, notice: '报价信息更新成功'
    else
      render action: "edit" 
    end
  end

  # DELETE /company_prices/1
  # DELETE /company_prices/1.json
  def destroy
    @company_prices = current_user.company_prices.where(id: params[:ids] || params[:id])
    @company_prices.destroy_all
    redirect_to company_prices_path
  end
end
