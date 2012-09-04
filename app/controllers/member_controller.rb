#coding: utf-8

class MemberController < ApplicationController
  before_filter :verify_member
  layout "member"
  
  def home
    @transactions = @user.transactions.order("refreshed_at DESC").limit(18)
    @news = @user.news.limit(10)
  end

  def show
  end

  def contact
  end

  def transactions
    @transactions = if params[:transaction_type_id]
      @user.transactions.where({transaction_type_id: (params[:transaction_type_id] == "" ? nil : params[:transaction_type_id])})
    elsif params[:keyword]
      Transaction.search_by_user(@user, params[:keyword])
    else
      @user.transactions
    end.paginate(page: params[:page], per_page: 18)
  end

  def transaction
    @transaction = @user.transactions.find(params[:id])
  end

  def news
    @news = @user.news.page(params[:page]).per_page(25)
  end

  def new 
    @new = @user.news.find(params[:id])
  end

  def message
  end

  private

  def verify_member
    @user = User.find_by_username(request.subdomain)
    if !@user || !@user.is_have_website
      redirect_to home_url
    end
  end

end
