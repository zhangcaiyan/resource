#coding: utf-8

class CustomerType < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :user_id
end
