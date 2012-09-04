# coding: utf-8

class CompanyPrice < ActiveRecord::Base
  belongs_to :user
  belongs_to :region
  belongs_to :city
  before_save :filter_unit, :filter_max_size, :modify_refreshed_at
  before_update :modify_valid

  with_options class_name: "CompanyPriceCategory" do |price|
    price.belongs_to :category1, foreign_key: :category1_id
    price.belongs_to :category2, foreign_key: :category2_id
    price.belongs_to :category3, foreign_key: :category3_id
  end

  symbolize :valid_time, in: [:ten_days, :twenty_days, :one_month, :three_months, :six_months, :chang_qi]

  validates_presence_of :category1_id, :category2_id, :name, :min_price, :region_id, :city_id, :valid_time
  validates :max_price, presence: true, numericality: true, if: :is_price_scope 
  validates :min_price, numericality: true, if: :min_price?
  validates :desc, length: {maximum: 2000}
  validates :unit, presence: true, if: lambda{|p| !p.other_unit?}
  validates :other_unit, format: {with: /.*\/.*/}, if: :other_unit?

  scope :valid, where(is_valid: true)
  scope :invalid, where(is_valid: false)

  default_value_for :valid_time, "chang_qi"

  def price
    min_price.to_s + (is_price_scope ? "至" + max_price.to_s : "") + unit
  end

  def unit
    u, o = (read_attribute :unit), (read_attribute :other_unit)
    u.present? ? u : o
  end

  def check_valid?
    case valid_time
    when :ten_days
      created_at + 10.days > Time.now
    when :twenty_days
      created_at + 20.days > Time.now
    when :one_month
      created_at + 1.month > Time.now
    when :three_months
      created_at + 3.months > Time.now
    when :six_months
      created_at + 6.months > Time.now
    when :chang_qi
      true
    end
  end

  def self.verify_expired
    [[:ten_days, 10.days], [:twenty_days, 20.days], [:one_month, 1.month], [:three_months, 3.months], [:six_months, 6.months]].each do |valid_times|
      self.search({refreshed_at_lte: (Time.now - valid_times[1]), valid_time_eq: valid_times[0], is_valid_eq: true}).relation.update_all(is_valid: false)
    end
  end

  def youxiaoqi
    is_valid ? valid_time_text : "信息已过期"
  end

  def suozaidi
    "#{region.name} #{city.name}"
  end

  def modify_valid
    if refreshed_at_changed? || valid_time_changed?
      self.is_valid = check_valid?
    end
    true
  end



  protected

  def filter_unit
    self.unit = nil if other_unit.present?
  end

  def filter_max_size
    self.max_price = nil if !is_price_scope
  end

  def modify_refreshed_at
    self.refreshed_at = Time.now
  end

end
