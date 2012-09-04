#coding: utf-8

class NewsController < ApplicationController
  before_filter :authenticate_user!, :news, :verify_have_website
  layout "admin"
  # GET /news
  # GET /news.json
  def index
    @news = news.page(params[:page]).per_page(20)
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @news = news.find(params[:id])
  end

  # GET /news/new
  # GET /news/new.json
  def new
    @news = news.new
  end

  # GET /news/1/edit
  def edit
    @news = news.find(params[:id])
  end

  # POST /news
  # POST /news.json
  def create
    @news = news.new(params[:news])

    if @news.save
      redirect_to news_index_path, notice: '动态信息添加成功.'
    else
      render action: "new"
    end
  end

  # PUT /news/1
  # PUT /news/1.json
  def update
    @news = news.find(params[:id])

    if @news.update_attributes(params[:news])
      redirect_to news_index_path, notice: '动态信息更新成功.'
    else
      render action: "edit"
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news = news.find(params[:id])
    @news.destroy
    redirect_to news_index_url
  end

  private

  def news 
    current_user.news
  end

  def verify_have_website
    redirect_to home_path unless current_user.is_have_website
  end
end
