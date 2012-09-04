#coding: utf-8

class ArticlesController < ApplicationController
  load_resource 
  authorize_resource except: :show

  before_filter :authenticate_user!, except: :show
  layout "admin", only: [:index, :new, :edit, :create, :update]

  def index
    @search = Article.search(params[:search])
    @articles = @search.where(category: params[:category]).order("created_at DESC").page(params[:page]).per_page(22)
  end

  def show
  end

  def new
    @article = Article.new(category: params[:category])
  end

  def edit
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      redirect_to articles_path(category: @article.category), notice: '发布文章成功'
    else
      render action: "new"
    end
  end

  def update
    if @article.update_attributes(params[:article])
      redirect_to articles_path(category: @article.category), notice: '修改文章成功.'
    else
      render action: "edit"
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path(category: @article.category)
  end

end
