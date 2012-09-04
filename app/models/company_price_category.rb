class CompanyPriceCategory < ActiveRecord::Base
  has_ancestry
  
  def company_prices
    CompanyPrice.where(category_id => id)
  end

  def category_id
    case depth
    when 0 then "category1_id"
    when 1 then "category2_id"
    when 2 then "category3_id"
    end
  end
end
