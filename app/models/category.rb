class Category < ActiveRecord::Base
  has_ancestry

  def transactions 
    Transaction.where(category_id => id )
  end

  def category_id
    case depth
    when 0 then "category1_id"
    when 1 then "category2_id"
    when 2 then "category3_id"
    when 3 then "category4_id"
    end
  end

end
