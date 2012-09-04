# coding: utf-8 

class UsersController < ApplicationController

  authorize_resource only: [:index, :update, :purview, :entverify, :verify, :entmember, :member] 
  load_resource only: [:show, :update, :entverify, :purview, :verify, :entmember, :member]

  before_filter :require_self_or_admin, only: :edit
  before_filter :authenticate_user!, except: [:verify_email_exist, :show, :verify_username_exist, :home]

  layout "admin", except: [:home]

  def index
    @search = User.search(params[:search])
    @users = @search.page(params[:page]).per_page(10).order("created_at DESC")
  end

  def show
  end

  def edit
  end

  def update
    if request.xhr?
      purview = params["purview"]
      if @user.tag_list.include?(purview)
        @user.tag_list.delete(purview)
      else
        @user.tag_list << purview
      end
      @user.save
      render text: @user.admin
    end
  end

  def verify_email_exist
    if request.xhr?
      render :text => User.exists?(email: params[:email])
    end
  end

  def verify_username_exist
    if request.xhr?
      render :text => User.exists?(username: params[:username])
    end
  end

  def entverify
  end

  def verify
    @user.is_verify = params[:user][:is_verify]
    @user.save
    redirect_to user_path(@user)
  end

  def purview
  end

  def entmember

  end

  def member
    @user.member = params[:user][:member]
    @user.save
    redirect_to user_path(@user)
  end

  def home
    @user = User.find(params[:id])
    @transactions = @user.transactions.page(params[:page]).per_page(12).order("created_at DESC")
  end

  def info_and_image
  end

  def edit_desc
  end

  def update_desc
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      redirect_to info_and_image_user_path(@user)
    else
      render "edit_desc"
    end
  end

  def edit_image
  end

  def edit_license
  end

end
