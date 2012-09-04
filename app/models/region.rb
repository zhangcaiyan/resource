# coding: utf-8 

class Region < ActiveRecord::Base
  has_many :cities, dependent: :destroy
  has_many :users, dependent: :nullify
  has_many :company_prices, dependent: :nullify
  belongs_to :country

  validates :name, presence: true
end
