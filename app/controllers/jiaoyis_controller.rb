class JiaoyisController < ApplicationController
  def index
  end

  def show
    @category = Category.roots.find(params[:id])
    @seeking_infos = Transaction.search({category1_id_eq: @category.id}).relation.seeking.order("created_at DESC").limit(6)
    @supply_infos = Transaction.search({category1_id_eq: @category.id}).relation.supply.order("created_at DESC").limit(6)
    @users = User.order("created_at DESC").limit(8)
    @tags = Transaction.where("category1_id = ?", @category.id).top_tags(20)
  end
end
