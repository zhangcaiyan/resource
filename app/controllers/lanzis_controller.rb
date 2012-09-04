#coding: utf-8

class LanzisController < ApplicationController
  before_filter :authenticate_user!

  layout "admin"

  # GET /shoucangs
  # GET /shoucangs.json
  def index
    @search = current_user.shoucangs.search(params[:search])
    @shoucangs = @search.page(params[:page]).per_page(15).order("created_at DESC")
  end

  # POST /shoucangs
  # POST /shoucangs.json
  def create
    @shoucang = current_user.shoucangs.find_or_create_by_transaction_id(params[:transaction_id])
    @shoucang.save
    redirect_to lanzis_path, notice: '收藏篮子成功'
  end

  # DELETE /shoucangs/1
  # DELETE /shoucangs/1.json
  def destroy
    if params[:shoucangs]
      current_user.shoucangs.where(id: params[:shoucangs].values).delete_all
    elsif params[:id]
      current_user.shoucangs.find_by_id(params[:id]).try(:destroy)
    end
    redirect_to lanzis_url(search: params[:search])
  end


end
