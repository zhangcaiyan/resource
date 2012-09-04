#coding: utf-8

class DongtaisController < ApplicationController
  load_resource 
  authorize_resource except: :show

  before_filter :filter_tag_list, only: [:create, :update]
  before_filter :authenticate_user!, except: :show
  layout "admin", only: [:index, :new, :edit, :create, :update]

  def index
    @search = Dongtai.search(params[:search])
    @dongtais = @search.order("created_at DESC").page(params[:page]).per_page(22)
  end

  def show
    @dongtai = Dongtai.find(params[:id])
    @jiages = @dongtai.resource.jiages.limit(12).order("published_at DESC")
  end

  def new
    @dongtai = KeyValues::Resource.first.dongtais.new(published_at: Date.current)
  end

  def edit
    @dongtai = Dongtai.find(params[:id])
  end

  def create
    @dongtai = Dongtai.new(params[:dongtai])

    if @dongtai.save
      redirect_to dongtais_path, notice: '创建成功'
    else
      render action: "new"
    end
  end

  def update
    @dongtai = Dongtai.find(params[:id])

    if @dongtai.update_attributes(params[:dongtai])
      redirect_to dongtais_path, notice: '创建成功'
    else
      render action: "edit"
    end
  end

  def destroy
    @dongtai = Dongtai.find(params[:id])
    @dongtai.destroy

    redirect_to dongtais_url
  end

  private

  def filter_tag_list
    params[:dongtai][:tag_list] = params[:dongtai][:tag_list].values.join(",")
  end

end
