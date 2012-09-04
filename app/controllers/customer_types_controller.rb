#coding: utf-8

class CustomerTypesController < ApplicationController
  before_filter :authenticate_user!, :customer_types
  # GET /customer_types
  # GET /customer_types.json
  def index
    @customer_types = customer_types
  end

  # GET /customer_types/1
  # GET /customer_types/1.json
  def show
    @customer_type = customer_types.find(params[:id])
  end

  # GET /customer_types/new
  # GET /customer_types/new.json
  def new
    @customer_type = customer_types.new
  end

  # GET /customer_types/1/edit
  def edit
    @customer_type = customer_types.find(params[:id])
  end

  # POST /customer_types
  # POST /customer_types.json
  def create
    @customer_type = customer_types.new(params[:customer_type])
    if @customer_type.save
      redirect_to customer_types_path, notice: '客户分类添加成功' 
    else
      render action: "new"
    end
  end

  # PUT /customer_types/1
  # PUT /customer_types/1.json
  def update
    @customer_type = customer_types.find(params[:id])
    if @customer_type.update_attributes(params[:customer_type])
      redirect_to customer_types_path, notice: '客户类型更新成功'
    else
      render action: "edit"
    end
  end

  # DELETE /customer_types/1
  # DELETE /customer_types/1.json
  def destroy
    @customer_type = customer_types.find(params[:id])
    @customer_type.destroy
    redirect_to customer_types_url
  end

  private

  def customer_types
    @customer_types = current_user.customer_types
  end
end
