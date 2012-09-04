class BaojiasController < ApplicationController

  def index
    @region_id = params[:search].try(:[], :region_id_eq)
    @city_id = params[:search].try(:[], :city_id_eq)
    @year = params[:year]
    @keyword = params[:search].try(:[], :name_or_category1_name_or_category2_name_or_category3_name_like)
    @category = CompanyPriceCategory.find_by_id(params[:id])
    @category2 = CompanyPriceCategory.find_by_id(params[:id2])
    params[:search].merge!(created_at_gte: Date.new(@year.to_i)).merge!(created_at_lte: Date.new(@year.to_i+1)-1) if @year.present?
    @search = CompanyPrice.search(params[:search])
    @company_prices = @search.relation.page(params[:page]).per_page(20).order("created_at DESC")
  end
end
