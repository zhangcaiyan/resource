# coding: utf-8

class JiagesController < ApplicationController

  load_resource except: :get_categories 
  authorize_resource except: :show

  before_filter :filter_tag_list, only: [:create, :update]
  before_filter :authenticate_user!, except: :show
  layout "admin", only: [:index, :new, :edit, :create, :update]

  def index
    @search = Jiage.search(params[:search])
    @jiages = @search.order("created_at DESC").page(params[:page]).per_page(22)
  end

  # GET /jiages/1
  # GET /jiages/1.json
  def show
    @jiage = Jiage.find(params[:id])
    @jiages = @jiage.resource.jiages.limit(12).order("published_at DESC")
  end

  # GET /jiages/new
  # GET /jiages/new.json
  def new
    @jiage = KeyValues::Resource.first.jiages.new(published_at: Date.current)
  end

  # GET /jiages/1/edit
  def edit
    @jiage = Jiage.find(params[:id])
  end

  # POST /jiages
  # POST /jiages.json
  def create
    @jiage = Jiage.new(params[:jiage])

    if @jiage.save
      redirect_to jiages_path, notice: '创建成功'
    else
      format.html { render action: "new" }
    end
  end

  # PUT /jiages/1
  # PUT /jiages/1.json
  def update
    @jiage = Jiage.find(params[:id])

    if @jiage.update_attributes(params[:jiage])
      redirect_to jiages_path, notice: '价格更新成功'
    else
      render action: "edit"
    end
  end

  # DELETE /jiages/1
  # DELETE /jiages/1.json
  def destroy
    @jiage = Jiage.find(params[:id])
    @jiage.destroy

    redirect_to jiages_url
  end

  def get_categories
    resource = KeyValues::Resource.find(params[:id])
    render json: resource.price_categories.collect{|category| {id: category.id, name: category.name}}
  end

  private

  def filter_tag_list
    params[:jiage][:tag_list] = params[:jiage][:tag_list].values.join(",")
  end

end
