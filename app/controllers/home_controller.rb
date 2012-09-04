# coding: utf-8 

class HomeController < ApplicationController
  def index
    @search = Transaction.search(params[:search])
    @transactions = @search.page(params[:page]).per_page(50).order("created_at DESC")
    @company_prices = CompanyPrice.order("created_at DESC").limit(9)
    @supply_infos = Transaction.supply.limit(6).order("created_at DESC")
    @seeking_infos = Transaction.seeking.limit(6).order("created_at DESC")
    @articles = Article.common.order("created_at DESC").limit(8)
    @article = Article.important.last
    @users = User.where({admin: false}).order("created_at DESC").limit(6)
    @tuijian_transactions = Transaction.order("created_at DESC").limit(6)
    @hangye_articles = Article.hangye.common.order("created_at DESC").limit(6)
    @zhengce_articles = Article.zhengce.common.order("created_at DESC").limit(6)
    @zaisheng_articles = Article.zaisheng.common.order("created_at DESC").limit(6)
    @zhishi_articles = Article.zhishi.common.order("created_at DESC").limit(6)
    @hangye_article = Article.hangye.less_important.last
    @zhengce_article = Article.zhengce.less_important.last
    @zaisheng_article = Article.zaisheng.less_important.last
    @zhishi_article = Article.zhishi.less_important.last
    @jiages_jinshu = Jiage.jinshu.order("published_at DESC").limit(8)
    @jiages_suliao = Jiage.suliao.order("published_at DESC").limit(8)
    @jiages_zhi = Jiage.zhi.order("published_at DESC").limit(8)
    @jiages_xiangjiao = Jiage.xiangjiao.order("published_at DESC").limit(8)

  end

  def search
    @category, @keyword, @refreshed_at = params["category"], params["keyword"], params[:refreshed_at]
    shijian = case @refreshed_at
              when "1" then 1.days
              when "3" then 3.days
              when "7" then 7.days
              when "30" then 1.month
              when "60" then 2.months
              end
    refreshed_at = shijian ? Time.now - shijian : nil
    if @category == "supply" || @category == "seeking" || @category.nil?
      @search = Transaction.search(params[:search].try(:merge, {refreshed_at_gte: refreshed_at})).relation.search_by_category(@category, @keyword)
      @transactions = @search.paginate(page: params[:page], per_page: 15)
      @company_prices = CompanyPrice.search({name_like: @keyword}).order("created_at DESC").limit(8)
      render "search_transactions"
    elsif @category == "price"
      @search = CompanyPrice.search({name_like: @keyword})
      @company_prices = @search.page(params[:page]).per_page(20).order("created_at DESC")
      render "search_company_prices"
    else 
      @search = Hangqingbaojia.search_by_title_or_tag(@keyword)
      @hangqings = @search.paginate(page: params[:page], per_page: 36)
      render "search_hangqingbaojias"
    end
    
  end

  def search_by_tag
    @tag = params[:tag]
    @transactions = Transaction.tagged_with(params[:tag]).page(params[:page]).per_page(10).order("created_at DESC")
    @company_prices = CompanyPrice.order("created_at DESC").limit(8)
    @tags = Transaction.search_by_title_and_category(@tag).top_tags(30)
    @articles = Article.order("created_at DESC").limit(8)
  end

  def shangbiao
  end

  def shengming
  end

  def services
  end

  def privacy
  end

  def ad
  end

  def lianxi
  end

  def recruit
  end

  def guanggao_attachment
    user_agent = request.user_agent.downcase
    file_name = user_agent.include?("msie") ? CGI::escape("资源再生交易平台商业推广书-广告.doc") : "资源再生交易平台商业推广书-广告.doc"
    send_file File.join(Rails.root, "public", "attachments", "guanggao_attachment.doc"), :type => "application/xlsx;charset=utf-8", :filename => file_name
  end

end
