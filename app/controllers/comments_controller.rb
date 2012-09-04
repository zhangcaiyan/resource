# coding: utf-8

class CommentsController < ApplicationController

  load_resource 
  authorize_resource except: :show

  before_filter :authenticate_user!, except: :show
  layout "admin", only: [:index, :new, :edit, :create, :update]

  def index
    @search = Comment.search(params[:search])
    @comments = @search.where(category: params[:category]).order("created_at DESC").page(params[:page]).per_page(22)
  end

  def show
    @comment = Comment.find(params[:id])
    @jiages = @comment.resource.jiages.limit(12).order("published_at DESC")
  end

  def new
    @comment = Comment.new(category: params[:category], published_at: Date.current)
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(params[:comment])

    if @comment.save
      redirect_to comments_path(category: @comment.category), notice: '创建成功'
    else
      render action: "new"
    end
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update_attributes(params[:comment])
      redirect_to comments_path(category: @comment.category), notice: '更新成功'
    else
      render action: "edit"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to comments_path(category: @comment.category)
  end

  def list
    @resource = KeyValues::Resource.find(params[:resource_id])
    @comments = (params[:category] == "day" ? @resource.comments.day : @resource.comments.week).order("published_at DESC").page(params[:page]).per_page(36)
    @category_name = params[:category] == "day" ? "日评" : "周评"
  end
end
