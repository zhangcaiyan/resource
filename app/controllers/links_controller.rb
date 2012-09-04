#coding: utf-8

class LinksController < ApplicationController

  before_filter :authenticate_user!, :links
  layout "admin"

  # GET /links
  # GET /links.json
  def index
  end

  # GET /links/1
  # GET /links/1.json
  def show
    @link = links.find(params[:id])
  end

  # GET /links/new
  # GET /links/new.json
  def new
    @link = links.new
  end

  # GET /links/1/edit
  def edit
    @link = links.find(params[:id])
  end

  # POST /links
  # POST /links.json
  def create
    @link = links.new(params[:link])

    if @link.save
      redirect_to links_path, notice: '友情链接保存成功.' 
    else
      render action: "new" 
    end
  end

  # PUT /links/1
  # PUT /links/1.json
  def update
    @link = links.find(params[:id])

    if @link.update_attributes(params[:link])
      redirect_to links_path, notice: '友情链接更新成功.' 
    else
      render action: "edit" 
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link = links.find(params[:id])
    @link.destroy
    redirect_to links_url 
  end

  private

  def links
    @links = current_user.links
  end
end
