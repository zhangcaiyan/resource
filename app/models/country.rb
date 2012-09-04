#coding: utf-8

class Country < ActiveRecord::Base
  has_many :regions, dependent: :nullify

  validates :name, presence: true
end
