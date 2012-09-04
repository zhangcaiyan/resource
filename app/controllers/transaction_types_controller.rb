#coding: utf-8

class TransactionTypesController < ApplicationController

  before_filter :authenticate_user!, :transaction_types
  layout "admin"

  # GET /trasaction_types
  # GET /trasaction_types.json
  def index
    @transaction_type = transaction_types.find_by_id(params[:id])
    @transactions = (@transaction_type.present? ? @transaction_type.transactions : current_user.transactions.where({transaction_type_id: nil})).paginate(page: params[:page], per_page: 20)
  end

  # GET /trasaction_types/1
  # GET /trasaction_types/1.json
  def show
    @transaction_type = transaction_types.find(params[:id])
  end
  # GET /trasaction_types/new
  # GET /trasaction_types/new.json
  def new
    @transaction_type = transaction_types.new
  end

  # GET /trasaction_types/1/edit
  def edit
    @transaction_type = transaction_types.find(params[:id])
  end

  # POST /trasaction_types
  # POST /trasaction_types.json
  def create
    @transaction_type = transaction_types.new(params[:transaction_type])

    if @transaction_type.save
      redirect_to transaction_types_path, notice: '供求类型添加成功.'
    else
      render action: "new"
    end
  end

  # PUT /trasaction_types/1
  # PUT /trasaction_types/1.json
  def update
    @transaction_type = transaction_types.find(params[:id])

    if @transaction_type.update_attributes(params[:transaction_type])
      redirect_to transaction_types_path, notice: '供求类型更新成功.'
    else
      render action: "edit" 
    end
  end

  # DELETE /trasaction_types/1
  # DELETE /trasaction_types/1.json
  def destroy
    @transaction_type = transaction_types.find(params[:id])
    @transaction_type.destroy
    redirect_to transaction_types_url
  end

  private

  def transaction_types
    @transaction_types = current_user.transaction_types
  end
end
