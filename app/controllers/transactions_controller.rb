# coding: utf-8

class TransactionsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :tags]
  before_filter :filter_tag_list, only: [:create, :update]
  after_filter :save_images, only: :create

  layout "admin", except: [:show]

  def index
    @search = current_user.transactions.search(params[:search])
    @transactions = @search.page(params[:page]).per_page(15).order("refreshed_at DESC")
  end

  def new
    @transaction = current_user.transactions.new(info_type: params[:info_type] || "supply" )
    @transaction.attachments.new
  end

  def edit
    @transaction = current_user.transactions.find(params[:id])
  end

  def show
    @transaction = Transaction.find(params[:id])
    @user = @transaction.user
    @transactions = @user.transactions.order("created_at DESC").page(params[:page]).per_page(10)
    @xg_transactions = Transaction.search({category2_id_eq: @transaction.category2_id}).order("created_at DESC").limit(10)
  end

  def create 
    @transaction = current_user.transactions.new(params[:transaction])
    if @transaction.save
      redirect_to transactions_path
    else
      render :new
    end
  end

  def update
    @transaction = current_user.transactions.find(params[:id])
    if @transaction.update_attributes(params[:transaction])
      redirect_to transactions_path
    else
      render :edit
    end
  end

  def destroy
    transaction = current_user.transactions.where(id: params[:id])
    transaction.destroy_all
    
    redirect_to transactions_path(search: params[:search])
  end

  def images
    @transaction = current_user.transactions.find(params[:id])
  end

  def tags  
    @tag_name, @transactions = params[:name], Transaction.tagged_with(params[:name]).page(params[:page]).per_page(50).order("created_at DESC")
  end

  def change_transaction_type
    transaction = current_user.transactions.find(params[:transaction_id])
    transaction.update_attribute(:transaction_type_id, params[:transaction_type_id])
    render nothing: true
  end

  def save_images
    if params["image_ids"].present?
      Attachment.where("id in (?)", params["image_ids"].split(",")).update_all(transaction_id: @transaction.id)
    end
  end

  def refresh
    transactions = current_user.transactions.where(id: params[:id])
    now = Time.now
    transactions.each do |t|
      t.update_attributes(refreshed_at: now)
    end
    if request.xhr?
      render json: {refreshed_at: I18n.l(now)}
    else
      redirect_to transactions_path(search: params[:search])
    end
  end

  def filter_tag_list
    params[:transaction][:tag_list] = params[:transaction][:tag_list].values.join(",")
  end

end
