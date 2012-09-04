#coding: utf-8

class MessagesController < ApplicationController
  before_filter :authenticate_user!
  after_filter :record_read, only: :show

  layout "admin"

  def index
    @messages = case params[:category]
    when "receive" then current_user.receive_messages.search(params[:search])
    when "send" then current_user.send_messages
    when "deleted" then current_user.deleted_messages
    else
      current_user.receive_messages
    end.page(params[:page]).per_page(16)
  end
  
  def show
    @message = current_user.messages.find(params[:id])
  end

  def new
    @message = current_user.send_messages.new(to_id: params[:to_id])
  end

  def create
    @message = current_user.send_messages.new(params[:message])
    if params["captcha"].nil? || simple_captcha_valid? 
      if @message.save
        if params["liuyan"].present?
          redirect_to :back, notice: "留言成功"
        else
          redirect_to messages_path(category: "send")
        end
      else
        redirect_to :back, alert: @message.errors.full_messages.join(",")
      end
    else
      flash[:captcha] = "验证码错误"
      redirect_to :back
    end
  end

  def update
    Message.huifu(current_user, params[:message_ids].values)
    redirect_to messages_path(category: params[:category])
  end

  def destroy
    Message.shanchu(current_user, params[:category], params[:delete_type],  params[:message_ids].values)
    redirect_to messages_path(category: params[:category])
  end

  private

  def record_read
    @message.update_attribute(:is_read, true) if !@message.is_read && @message.to_id == current_user.id
  end

end
