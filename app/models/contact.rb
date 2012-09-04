#coding: utf-8

class Contact < ActiveRecord::Base
  belongs_to :user

  default_value_for :gender, :male
  default_value_for :is_public, true

  symbolize :gender, in: [:male, :female], scopes: true, methods: true

  validates_presence_of :name, :cell_phone, :gender
  validates :email, format: { with: RubyRegex::Email }, if: :email?

  def call
    name + " " + (gender == :male ? "先生" : "女士")
  end

  def is_public_text
    is_public ? "是" : "否"
  end
end
