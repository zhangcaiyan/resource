#coding: utf-8 
require "will_paginate/array"

class Transaction < ActiveRecord::Base

  belongs_to :user
  belongs_to :category1, class_name: "Category"
  belongs_to :category2, class_name: "Category"
  belongs_to :category3, class_name: "Category"
  belongs_to :category4, class_name: "Category"
  belongs_to :transaction_type
  has_many :attachments, dependent: :destroy
  has_many :shoucangs, dependent: :destroy
  has_many :users, through: :shoucangs, source: :user, order: "created_at DESC"
  

  acts_as_taggable

  accepts_nested_attributes_for :attachments, allow_destroy: true

  before_save :verify_separator
  before_create :add_refreshed_at
  before_update :modify_valid

  symbolize :info_type, in: [:supply, :seeking], scopes: true
  symbolize :manufacture, in: [:z, :a, :b]
  symbolize :valid_time, in: [:ten_days, :twenty_days, :one_month, :three_months, :chang_qi]
  symbolize :goods_type, in: [:xian_huo, :qi_huo, :qi_ta]
  symbolize :provide_statu, in: [:changqi, :budingqi]

  default_value_for :quantity_unit, "吨"
  default_value_for :price_unit, "元"
  default_value_for :info_type, "supply"
  default_value_for :manufacture, "z"
  default_value_for :valid_time, "twenty_days"
  default_value_for :goods_type, "xian_huo"
  default_value_for :provide_statu, "changqi"


  validates_presence_of :info_type, :title, :source, :quantity, :quantity_unit, :provide_statu, :price_unit, :valid_time, :location, :goods_type, :desc, :manufacture, :category1_id, :category2_id

  validates :title, length: {maximum: 50}, if: :title?
  validates :source, length: {maximum: 50}, if: :source?
  validates :location, length: {maximum: 50}, if: :location?
  validates :quantity, numericality: true, if: :quantity?
  validates :desc, length: {maximum: 500}, if: :desc?
  validates :max_price, numericality: true, allow_nil: true
  validates :min_price, numericality: true, allow_nil: true
  validate :check_refresh, on: :update

  scope :valid, where(is_valid: true)
  scope :invalid, where(is_valid: false)

  def price 
    [min_price, max_price].compact.join("-")
  end

  def price_by_unit
    [[price, price_unit].join(" "), quantity_unit].join("/") if price.present?
  end

  def provide_quantity_by_unit
    [provide_quantity, quantity_unit].join(" ") if provide_quantity.present?
  end

  def name
    "#{info_type_text}  #{title}"
  end

  def self.search_by_user(user, keyword)
    t1 = keyword.present? ? user.transactions.tagged_with(keyword, any: true, wild: true) : []
    t2 = user.transactions.search({title_or_category1_name_or_category2_name_or_category3_name_or_category4_name_like: keyword}).relation
    [t1 + t2].flatten.uniq.sort{|a, b| b.refreshed_at <=> a.refreshed_at}
  end

  def self.search_by_category(category, keyword)
    t1 = keyword.present? ? Transaction.search({info_type_eq: category}).relation.tagged_with(keyword, any: true, wild: true) : []
    t2 = Transaction.search({info_type_eq: category, title_or_category1_name_or_category2_name_or_category3_name_or_category4_name_like: keyword}).relation
    [t1 + t2].flatten.uniq.sort{|a, b| b.refreshed_at <=> a.refreshed_at}
  end

  def self.search_by_title_and_category(keyword)
    Transaction.search({title_or_category1_name_or_category2_name_or_category3_name_like: keyword}).relation
  end

  def youxiaoqi
    is_valid ? valid_time_text : "信息已过期"
  end

  def can_upload_image?
    if user.common_member?
      attachments.size >= 1 ? false : true
    elsif user.advanced_member?
      attachments.size >= 5 ? false : true
    end
  end

  def trace_images_size
    (user.common_member? ? 1 : 5) - attachments.size
  end

  def check_valid?
    case valid_time
    when :ten_days
      refreshed_at + 10.days > Time.now
    when :twenty_days
      refreshed_at + 20.days > Time.now
    when :one_month
      refreshed_at + 1.month > Time.now
    when :three_months
      refreshed_at + 3.months > Time.now
    when :chang_qi
      true
    end
  end

  def self.verify_expired
    [[:ten_days, 10.days], [:twenty_days, 20.days], [:one_month, 1.month], [:three_months, 3.months]].each do |valid_times|
      self.search({refreshed_at_lte: (Time.now - valid_times[1]), valid_time_eq: valid_times[0], is_valid_eq: true}).relation.update_all(is_valid: false)
    end
  end

  def modify_valid
    if refreshed_at_changed? || valid_time_changed?
      self.is_valid = check_valid?
    end
    true
  end

  def can_refresh?(time = nil)
    refreshed_at = time.present? ? time : self.refreshed_at
    if user.advanced_member?
      refreshed_at + 30.minutes < Time.now
    else
      refreshed_at + 1.day < Time.now
    end
  end

  def self.call_back_refreshed_at(time = nil)
    time = time.present? ? time : 10.days
    self.all.each do |t|
      t.update_attribute(:refreshed_at, t.refreshed_at - time)
    end
  end

  def category_name
    category4.try(:name) || category3.try(:name) || category2.try(:name)
  end

  protected

  def verify_separator
    self.tag_list =  self.tag_list.join(",").gsub("，", ",")
  end

  def add_refreshed_at
    self.refreshed_at = Time.now
  end

  def check_refresh
    if refreshed_at_changed? && !can_refresh?(refreshed_at_change.first) 
      message = user.advanced_member? ? "您需要在上一次刷新后半小时才可以刷新" : "您需要在上一次刷新后1天才可以刷新"
      self.errors.add("refreshed_at", message) 
    end
  end

  
end
