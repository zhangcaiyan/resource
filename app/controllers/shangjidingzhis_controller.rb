#coding: utf-8

class ShangjidingzhisController < ApplicationController

  before_filter :authenticate_user!
  layout "admin", except: [:new, :edit]

  # GET /shangjidingzhis
  # GET /shangjidingzhis.json
  def index
    @shangjidingzhis = current_user.shangjidingzhis.paginate(page: params[:page], per_page: 15).order("created_at DESC")
  end

  # GET /shangjidingzhis/1
  # GET /shangjidingzhis/1.json
  def show
   
  end

  # GET /shangjidingzhis/new
  # GET /shangjidingzhis/new.json
  def new
    @shangjidingzhi = current_user.shangjidingzhis.new
  end

  # GET /shangjidingzhis/1/edit
  def edit
    @shangjidingzhi = current_user.shangjidingzhis.find(params[:id])
  end

  # POST /shangjidingzhis
  # POST /shangjidingzhis.json
  def create
    @shangjidingzhi = current_user.shangjidingzhis.new(params[:shangjidingzhi])
    if @shangjidingzhi.save
    redirect_to shangjidingzhis_path, notice: '商机定制成功.'
    else
      render action: "new"
    end
  end

  # PUT /shangjidingzhis/1
  # PUT /shangjidingzhis/1.json
  def update
    @shangjidingzhi = current_user.shangjidingzhis.find(params[:id])
    if @shangjidingzhi.update_attributes(params[:shangjidingzhi])
      redirect_to shangjidingzhis_path, notice: '商机定制成功.'
    else
      render action: "edit"
    end
  end

  # DELETE /shangjidingzhis/1
  # DELETE /shangjidingzhis/1.json
  def destroy
    @shangjidingzhi = current_user.shangjidingzhis.find(params[:id])
    @shangjidingzhi.destroy
    redirect_to shangjidingzhis_url
  end

  def list
    @shangjidingzhis = current_user.shangjidingzhis
    shangjidingzhi = @shangjidingzhis.find_by_id(params[:id] || @shangjidingzhis.first)
    @transactions = shangjidingzhi.nil? ? [] : shangjidingzhi.transactions.paginate(page: params[:page], per_page: 8) 
  end


end
