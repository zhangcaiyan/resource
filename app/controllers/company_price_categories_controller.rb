# coding: utf-8

class CompanyPriceCategoriesController < ApplicationController
  def show
    if request.xhr?
      prompt = params[:type] == "1" ? "请选择二级分类" : "请选择三级分类"
      category = CompanyPriceCategory.find_by_id(params[:category_id])
      cotegories = (category ? category.children.collect{|c| [c.id, c.name]} : []).insert(0, ["", prompt])
      render :text => cotegories.collect{|c| "<option value='#{c[0]}'>#{c[1]}</option>"}.join(",")
    end
  end
end
