#coding: utf-8

class Customer < ActiveRecord::Base
  belongs_to :user
  belongs_to :country
  belongs_to :region
  belongs_to :city
  belongs_to :customer_type

  default_value_for :gender, :male
  default_value_for :rating, :four
  default_value_for :status, :yi
  default_value_for :country_id, 1

  symbolize :gender, in: [:male, :female], scopes: true, methods: true
  symbolize :rating, in: [:one, :two, :three, :four, :five], scopes: true, methods: true
  symbolize :status, in: [:yi, :er, :san], scopes: true, methods: true

  validates_presence_of :name, :country_id, :customer_type_id

  def call
    name + " " + (gender == :male ? "先生" : "女士")
  end

  def dizhi
    region.try(:name).present? ? "#{region.name} #{city.name}" : country.try(:name)
  end
  
end
