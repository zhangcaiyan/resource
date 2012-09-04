# coding: utf-8 

class City < ActiveRecord::Base
  has_many :users, dependent: :nullify
  has_many :company_prices, dependent: :nullify
  belongs_to :region

  validates :name, presence: true
end
