#coding: utf-8

class CountriesController < ApplicationController
  def show 
    if request.xhr?
      country = Country.find_by_id(params[:country_id])
      regions = (country ? country.regions.collect{|region| [region.id, region.name]} : []).insert(0, ["", "请选择省份"])
      render :text => regions.collect{|region| "<option value='#{region[0]}'>#{region[1]}</option>"}.join(",")
    end
  end
end
