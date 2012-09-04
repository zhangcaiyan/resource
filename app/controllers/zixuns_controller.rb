class ZixunsController < ApplicationController
  def index
    @hangye_jinshu_articles = Article.hangye.jinshu.common.order("created_at DESC").limit(6)
    @hangye_shuliao_articles = Article.hangye.shuliao.common.order("created_at DESC").limit(6)
    @hangye_zhi_articles = Article.hangye.zhi.common.order("created_at DESC").limit(6)
    @hangye_qita_articles = Article.hangye.qita.common.order("created_at DESC").limit(6)
    @zaisheng_jinshu_articles = Article.zaisheng.jinshu.common.order("created_at DESC").limit(6)
    @zaisheng_shuliao_articles = Article.zaisheng.shuliao.common.order("created_at DESC").limit(6)
    @zaisheng_zhi_articles = Article.zaisheng.zhi.common.order("created_at DESC").limit(6)
    @zaisheng_qita_articles = Article.zaisheng.qita.common.order("created_at DESC").limit(6)
    @hangye_jinshu_article = Article.hangye.jinshu.less_important.last
    @hangye_shuliao_article = Article.hangye.shuliao.less_important.last
    @hangye_zhi_article = Article.hangye.zhi.less_important.last
    @hangye_qita_article = Article.hangye.qita.less_important.last
    @zaisheng_jinshu_article = Article.zaisheng.jinshu.less_important.last
    @zaisheng_shuliao_article = Article.zaisheng.shuliao.less_important.last
    @zaisheng_zhi_article = Article.zaisheng.zhi.less_important.last
    @zaisheng_qita_article = Article.zaisheng.qita.less_important.last
    @users = User.where({admin: false}).order("created_at DESC").limit(20)
    @important_article1 = Article.first_important
    @important_article2 = Article.second_important

  end

  def list
    @category_name = Article.category_name(params[:search][:category_eq])
    @fenlei_name = Article.fenlei_name(params[:search][:fenlei_eq])
    @search = Article.search(params[:search])
    @articles = @search.page(params[:page]).per_page(10).order("created_at DESC")
    @zonghe_articles = Article.limit(8).order("created_at DESC")
    @qita_articles = Article.where("category != ?", params[:search][:category_eq]).order("created_at DESC").limit(8)
  end
end
