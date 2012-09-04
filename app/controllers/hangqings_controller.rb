#coding: utf-8

class HangqingsController < ApplicationController
  load_resource 
  authorize_resource except: :show

  before_filter :filter_tag_list, only: [:create, :update]
  before_filter :authenticate_user!, except: :show
  layout "admin", only: [:index, :new, :edit, :create, :update]

  def index
    @search = Hangqing.search(params[:search])
    @hangqings = @search.order("created_at DESC").page(params[:page]).per_page(22)
  end

  def show
    @hangqing = Hangqing.find(params[:id])
    @jiages = @hangqing.resource.jiages.limit(12).order("published_at DESC")
  end

  def new
    @hangqing = KeyValues::Resource.first.hangqings.new(published_at: Date.current)
  end

  def edit
    @hangqing = Hangqing.find(params[:id])
  end

  def create
    @hangqing = Hangqing.new(params[:hangqing])

    if @hangqing.save
      redirect_to hangqings_path, notice: '创建成功'
    else
      render action: "new"
    end
  end

  def update
    @hangqing = Hangqing.find(params[:id])

    if @hangqing.update_attributes(params[:hangqing])
      redirect_to hangqings_path, notice: '创建成功'
    else
      render action: "edit"
    end
  end

  def destroy
    @hangqing = Hangqing.find(params[:id])
    @hangqing.destroy

    redirect_to hangqings_url
  end

  private

  def filter_tag_list
    params[:hangqing][:tag_list] = params[:hangqing][:tag_list].values.join(",")
  end

end
