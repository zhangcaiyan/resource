# coding: utf-8 

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_taggable

  before_update :update_super_admin
  before_update :manage_admin
  before_update :manage_member
  before_update :manage_member_at
  after_create :create_customer_types
  after_create :create_message_types

  delegate :name, to: :country, prefix: true, allow_nil: true
  delegate :name, to: :region, prefix: true, allow_nil: true
  delegate :name, to: :city, prefix: true, allow_nil: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_protected :admin, :confirmed_at, :is_verify, :super_admin, :member, :is_have_website
  attr_accessor :login

  belongs_to :country
  belongs_to :region 
  belongs_to :city 
  has_one :attachment, dependent: :destroy, conditions: {category: "license"}
  has_many :attachments, dependent: :destroy, conditions: {category: nil}
  has_many :contacts, dependent: :destroy
  has_many :company_prices, dependent: :nullify
  has_many :shangjidingzhis, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :transaction_types, dependent: :destroy
  has_many :news, dependent: :destroy, order: "created_at DESC"
  has_many :customers, dependent: :destroy, order: "created_at DESC"
  has_many :customer_types, dependent: :destroy
  has_many :shoucangs, dependent: :destroy
  has_many :lanzis, through: :shoucangs, source: :transaction, order: "created_at DESC"
  has_many :message_types
  with_options class_name: "Message", order: "created_at DESC" do |user|
    user.has_many :send_messages, foreign_key: :from_id, conditions: {is_from_soft_deleted: false, is_from_deleted: false}
    user.has_many :receive_messages, foreign_key: :to_id, conditions: {is_to_soft_deleted: false, is_to_deleted: false}
  end

  scope :admin, where(admin: true)
  scope :no_admin, where(admin: false)

  def company_name
    (c_n = read_attribute(:company_name)).present? ? c_n : "个体经营 (#{name})"
  end

  def messages
    Message.where(["from_id = ? AND is_from_deleted = ? OR to_id = ? AND is_to_deleted = ?", id, false, id, false])
  end

  def deleted_messages
    Message.where(["from_id = ? AND is_from_soft_deleted = ? AND is_from_deleted = ? OR to_id = ? AND is_to_soft_deleted = ? AND is_to_deleted = ?", id, true, false, id, true, false ]).order("created_at DESC")
  end

  accepts_nested_attributes_for :attachments, allow_destroy: true

  with_options dependent: :nullify, class_name: "Transaction" do |user|
    user.has_many :transactions 
    user.has_many :supplyinfos, conditions: {info_type: "supply"}
    user.has_many :seekinginfos, conditions: {info_type: "seeking"}
  end


  symbolize :category, in: [:buy_and_sell, :buy, :sell], scopes: true, methods: true
  symbolize :business_category, in: [:a, :b, :c, :d, :e, :f, :g, :h, :i], scopes: true, methods: true
  symbolize :gender, in: [:male, :female], scopes: true, methods: true
  
  symbolize :admin, in: [true, false]
  symbolize :is_verify, in: [true, false]
  symbolize :member, in: [:a, :b, :c]

  default_value_for :country_id, 1
  default_value_for :category, "buy_and_sell"
  default_value_for :gender, "male"
  default_value_for :super_admin, false
  default_value_for :admin, false

  validates :email, uniqueness: true, format: { with: RubyRegex::Email }, if: :email?
  validates :backup_email, format: { with: RubyRegex::Email }, allow_blank: true
  validates :company_url, format: { with: RubyRegex::Url }, allow_blank: true
  validates :username, length: 4..25, uniqueness: true, format: {with: RubyRegex::Username}
  validates :password, presence: true, confirmation: true, if: :password_required?
  validates :name, length: 2..15, if: :name?
  validates :gender, inclusion: {in: [:male, :female]}, if: :gender?
  validates :category, inclusion: {in: [:buy_and_sell, :buy, :sell]}, if: :category?
  validates :desc, length: {maximum: 2000}
  validates :business, length: {maximum: 2000}
  validates_presence_of :category, :business_category, :email, :name, :gender, :address, :phone, :country_id


  def suozaidi
    region ? "#{region_name} #{city_name}" : country.name
  end

  def country_or_region
    region ? region.name : country.name
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.strip.downcase }]).first
  end

  def call
    name + "  " + (gender == :male ? "先生" : "女士")
  end

  def advanced_member?
    member != :a
  end

  def common_member?
    member == :a
  end

  def valid_email
    is_email_valid? || !backup_email.present? ? email : backup_email
  end

  def unread_message_size
    receive_messages.unread.size
  end


  protected

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def update_super_admin
    self.admin = true if super_admin_changed? && super_admin
  end

  def manage_admin
    self.admin = tag_list.blank? ? false : true if !super_admin
    true
  end

  def manage_member
    if member_changed?
      self.is_have_website = member != :a ? true : false
    end
    true
  end

  def manage_member_at
    if member_changed? && member != :a
      self.member_at = DateTime.now 
    end
    true
  end

  def create_customer_types
    ["我的供应商", "我的采购商", "商界好友"].each do |name|
      customer_types.create(name: name)
    end
  end

  def create_message_types
    ["普通留言", "重要留言"].each do |name| 
      message_types.create(name: name)
    end
  end

  
end


