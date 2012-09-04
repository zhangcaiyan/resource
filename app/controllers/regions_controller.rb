# coding: utf-8

class RegionsController < ApplicationController
  def show 
    if request.xhr?
      region = Region.find_by_id(params[:region_id])
      cities = (region ? region.cities.collect{|city| [city.id, city.name]} : []).insert(0, ["", "请选择城市"])
      render :text => cities.collect{|city| "<option value='#{city[0]}'>#{city[1]}</option>"}.join(",")
    end
  end
end
