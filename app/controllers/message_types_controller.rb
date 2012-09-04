#coding: utf-8

class MessageTypesController < ApplicationController

  before_filter :authenticate_user!, :message_types
  # GET /message_types
  # GET /message_types.json
  def index
  end

  # GET /message_types/1
  # GET /message_types/1.json
  def show
    @message_type = message_types.find(params[:id])
  end

  # GET /message_types/new
  # GET /message_types/new.json
  def new
    @message_type = message_types.new
  end

  # GET /message_types/1/edit
  def edit
    @message_type = message_types.find(params[:id])
  end

  # POST /message_types
  # POST /message_types.json
  def create
    @message_type = message_types.new(params[:message_type])

      if @message_type.save
        redirect_to message_types_url, notice: '留言类型保存成功'
      else
        render action: "new"
      end
  end

  # PUT /message_types/1
  # PUT /message_types/1.json
  def update
    @message_type = MessageType.find(params[:id])

    if @message_type.update_attributes(params[:message_type])
      redirect_to message_types_url, notice: '留言类型更新成功'
    else
      render action: "edit"
    end
  end

  # DELETE /message_types/1
  # DELETE /message_types/1.json
  def destroy
    @message_type = MessageType.find(params[:id])
    @message_type.destroy

    redirect_to message_types_url
  end

  private

  def message_types
    @message_types = current_user.message_types
  end
end
