#coding: utf-8
require "will_paginate/array"

class Shangjidingzhi < ActiveRecord::Base
  belongs_to :user
  belongs_to :region
  belongs_to :city
  
  default_value_for :info_type, :all

  symbolize :info_type, in: [:supply, :seeking, :all]

  validates :keyword, presence: true

  attr_reader :email

  def address
    (address = [region.try(:name), city.try(:name)].join("  ")).blank? ? "无地区信息" : address
  end

  def is_send_email_text
    is_send_email ? "邮件提醒" : "无邮件提醒"
  end

  def transactions(limit = nil)
    t1 = Transaction.tagged_with(keyword, any: true, wild: true).limit(limit)
    t2 = Transaction.search_by_title_and_category(keyword).limit(limit)
    ts = [t1 + t2].flatten.uniq
    (limit.nil? ? ts : ts.slice(0, limit)).sort{|a, b| b.created_at <=> a.created_at}
  end

  def self.start_job
    users = User.find(Shangjidingzhi.where(is_send_email: true).group(:user_id).pluck(:user_id))
    Delayed::Job.enqueue(ShangjidingzhiJob.new(users))
  end

end
