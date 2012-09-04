# coding: utf-8 

class ApplicationController < ActionController::Base
  protect_from_forgery

  include SimpleCaptcha::ControllerHelpers

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      redirect_to admin_url, :alert => "抱歉，您无权访问这个页面，请联系管理员为您添加权限"
    else
      redirect_to new_user_session_path, :notice => '抱歉，您需要先登陆'
    end
  end

  if Rails.env.prodution?
    rescue_from Exception, :with => :error
  end

  def error
    render :file => "/errors/error.html.erb", :layout => "application"
  end 

  protected 

  def after_sign_in_path_for(resource)
    resource.admin ? admin_path : home_path
  end

  def verify_admin
    redirect_to home_path if !current_user.admin?
  end

  def require_self_or_admin
    if !current_user.admin? && current_user.id != params[:id]
      redirect_to home_path
    end
  end


end
