#coding: utf-8

class MessageType < ActiveRecord::Base
  belongs_to :user
  has_many :messages, dependent: :nullify

  validates_presence_of :name, :user_id
end
