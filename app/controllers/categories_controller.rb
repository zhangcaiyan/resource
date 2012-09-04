# coding: utf-8

class CategoriesController < ApplicationController
  def show
    if request.xhr?
      category = Category.find_by_id(params[:category_id])
      cotegories = category.children.collect{|c| [c.id, c.name]}.insert(0, ["", get_select_type(category)])
      render :text => cotegories.collect{|c| "<option value='#{c[0]}'>#{c[1]}</option>"}.join(",")
    end
  end

  private

  def get_select_type(category)
    case category.depth
    when 0 then "二级分类"
    when 1 then "三级分类"
    when 2 then "四级分类"
    end
  end
end
