#coding: utf-8

class AttachmentsController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, only: [:create]

  def index
    @attachments = Attachment.order(order_param)
    @json = []  
    for atta in @attachments  
      temp =  %Q/{"filesize" : #{atta.image.size},  
      "filename" : "#{atta.image_file_name}",  
      "is_photo" : true,
      "dir_path" : "#{atta.image.url}",  
      "datetime" : "#{atta.created_at}"}/  
      @json << temp
    end     
    render :text => ("{\"file_list\":[" << @json.join(", ") << "]}")
  end

  def create
    @attachment = Attachment.new(params[:attachment])
    respond_to do |format|
      if @attachment.save
        format.html{
          if @attachment.transaction_id
            redirect_to images_transaction_path(params[:attachment][:transaction_id])
          elsif @attachment.company_picture?
            redirect_to edit_image_user_path(current_user)
          elsif @attachment.license_picture?
            redirect_to edit_license_user_path(current_user)
          end
        }
        format.js{
          render json: {is_success: true, id: @attachment.id, url: @attachment.image.url, preview_id: params[:preview_id]}, content_type: "text/html"
        }
      else
        format.html{
          redirect_to :back, flash: {error_messages: @attachment.errors.messages.values.flatten.uniq}
        }
        format.js{
          render json: {is_success: false, errors: @attachment.errors.messages.values.flatten, preview_id: params[:preview_id]}, content_type: "text/html"
        }
      end
    end 
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    if @attachment.transaction_id
      redirect_to images_transaction_path(@attachment.transaction.id) 
    elsif @attachment.company_picture?
      redirect_to edit_image_user_path(current_user)
    elsif @attachment.license_picture?
      redirect_to edit_license_user_path(current_user)
    end
  end

  def upload 
    @attachment = Attachment.new(:image => params[:imgFile])  
    if @attachment.save  
      render :text => {"error" => 0, "url" => @attachment.image.url}.to_json  
    else  
      render :text => {"error" => @attachment.errors[:image_file_size]}  
    end
  end

  private

  def order_param
    case params[:order]
    when 'NAME' then "image_file_name" 
    when 'SIZE' then "image_file_size"
    when 'TYPE' then "image_content_type"
    else
      "image_file_name"
    end
  end

end
