# coding: utf-8

module TransactionsHelper

  def transaction_title(info_type)
    case info_type
    when nil then "供求信息列表"
    when "supply" then "供应信息列表"
    when "seeking" then "求购信息列表"
    end
  end

  def transaction_price(transaction)
    transaction.price + transaction.price_unit + "/" + transaction.quantity_unit
  end

  def transaction_quantity(transaction)
    "#{transaction.quantity} #{transaction.quantity_unit}" if transaction.quantity?
  end

  def transaction_provide_quantity(transaction)
    transaction.provide_quantity.to_s + transaction.quantity_unit
  end

  def quantity_unit_other(transaction, quantity_unit)
    if transaction.new_record?
      ["吨", "千克", "斤"].include?(quantity_unit) ? "" : quantity_unit
    else
      ["吨", "千克", "斤"].include?(transaction.quantity_unit) ? "" : transaction.quantity_unit
    end
  end

  def price_unit_other(transaction, price_unit)
    if transaction.new_record?
      ["元", "美元"].include?(price_unit) ? "" : price_unit
    else
      ["元", "美元"].include?(transaction.price_unit) ? "" : transaction.price_unit
    end
  end




end
