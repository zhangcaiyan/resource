#coding: utf-8

class TransactionType < ActiveRecord::Base

  belongs_to :user
  has_many :transactions, dependent: :nullify

  validates :name, presence: true, length: {maximum: 20}
  validates :desc, length: {maximum: 1000}

end
