class HangqingbaojiasController < ApplicationController
  def index
    @jinshu = KeyValues::Resource.first
    @suliao = KeyValues::Resource.find(2)
    @zhi = KeyValues::Resource.find(3)
    @xiangjiao = KeyValues::Resource.find(4)
    @jinshu_prices = @jinshu.jiages.order("published_at DESC").limit(8)
    @jinshu_dongtais = @jinshu.dongtais.order("published_at DESC").limit(8)
    @jinshu_hangqings = @jinshu.hangqings.order("published_at DESC").limit(8)
    @suliao_prices = @suliao.jiages.order("published_at DESC").limit(8)
    @suliao_dongtais = @suliao.dongtais.order("published_at DESC").limit(8)
    @suliao_hangqings = @suliao.hangqings.order("published_at DESC").limit(8)
    @zhi_prices = @zhi.jiages.order("published_at DESC").limit(8)
    @zhi_dongtais = @zhi.dongtais.order("published_at DESC").limit(4)
    @xiangjiao_prices = @xiangjiao.jiages.order("published_at DESC").limit(8)
    @xiangjiao_hangqings = @xiangjiao.hangqings.order("published_at DESC").limit(4)
    @jinshu_ripings = KeyValues::Resource.first.comments.day.order("published_at DESC").limit(4)
    @jinshu_zoupings = KeyValues::Resource.first.comments.week.order("published_at DESC").limit(4)
    @suliao_ripings = KeyValues::Resource.find(2).comments.day.order("published_at DESC").limit(4)
    @suliao_zoupings = KeyValues::Resource.find(2).comments.week.order("published_at DESC").limit(4)
    @zhi_ripings = KeyValues::Resource.find(3).comments.day.order("published_at DESC").limit(4)
    @zhi_zoupings = KeyValues::Resource.find(3).comments.week.order("published_at DESC").limit(4)
  end

  def jiage_list
    @resource = KeyValues::Resource.find(params[:id])
  end

  def more_jiage_list
    @category = KeyValues::PriceCategory.find(params[:id])
    @jiages = @category.jiages.order("published_at DESC").page(params[:page]).per_page(72)
  end

  def dongtai_list
    @resource = KeyValues::Resource.find(params[:id])
  end
  
  def more_dongtai_list
    @region = KeyValues::DongtaiCategory.find_by_id(params[:id])
    @dongtais = (@region ? @region.dongtais : Dongtai.where(["region_id > 6 OR region_id == 5"])).order("published_at DESC").page(params[:page]).per_page(72)
  end
  
  def hangqing_list
    @resource = KeyValues::Resource.find(params[:id])
    @hangqings = @resource.hangqings.order("published_at DESC").page(params[:page]).per_page(72)
  end


end
