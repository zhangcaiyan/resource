#coding: utf-8

class CustomersController < ApplicationController

  before_filter :authenticate_user!, :customers
  layout "admin"

  # GET /customers
  # GET /customers.json
  def index
    @search = customers.search(params[:search])
    @customers = @search.page(params[:page]).per_page(16)
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = customers.find(params[:id])
  end

  # GET /customers/new
  # GET /customers/new.json
  def new
    @customer = customers.new
  end

  # GET /customers/1/edit
  def edit
    @customer = customers.find(params[:id])
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = customers.new(params[:customer])

    if @customer.save
      redirect_to customers_path, notice: '客户信息保存成功' 
    else
      render action: "new" 
    end
  end

  # PUT /customers/1
  # PUT /customers/1.json
  def update
    @customer = customers.find(params[:id])

    if @customer.update_attributes(params[:customer])
      redirect_to customers_path, notice: '客户信息更新成功' 
    else
      render action: "edit" 
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    if params[:customers]
      customers.where(id: params[:customers].values).delete_all
    elsif params[:id]
      customers.find_by_id(params[:id]).try(:destroy)
    end
    redirect_to customers_url(search: params[:search])
  end

  private

  def customers
    @customers = current_user.customers
  end
end
