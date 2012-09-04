# coding: utf-8

class Attachment < ActiveRecord::Base
  belongs_to :user
  belongs_to :transaction

  symbolize :category, in: [:license], scopes: true, methods: true, allow_nil: true

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }

  validates_attachment_size :image, less_than: 2.megabytes, message: "不能超过2M" 
  validates_attachment_presence :image, message: "请上传图片"
  validates_attachment_content_type :image, :content_type => ['image/gif', 'image/png', 'image/x-png', 'image/jpg', 'image/jpeg', 'image/pjpeg', 'image/bmp'], message: "请上传图片，并且格式为gif、png、jpg、jpeg、bmp"

  validates :transaction_id, uniqueness: {message: "普通会员每条供求信息只能上传1张图片"}, if: :verify_upload_images_for_common_member?,  allow_nil: true

  validates :user_id, uniqueness: {message: "普通会员只能上传1张公司相关图片", scope: :category}, if: :verify_upload_company_images_for_common_member?,  allow_nil: true

  validates :user_id, uniqueness: {message: "只能上传一张执照", scope: :category}, if: :verify_upload_license_images

  validate :verify_upload_images_for_advanced_member?
  validate :verify_upload_company_images_for_advanced_member?

  def self.delete_invalid_images
    self.search({user_id_is_null: true, transaction_id_is_null: true, created_at_lte: Time.now-6.hours}).relation.delete_all
  end

  def company_picture?
    user && category.nil?
  end

  def license_picture?
    user && category == :license
  end

  private

  def verify_upload_images_for_common_member?
    transaction && transaction.user.common_member?
  end

  def verify_upload_company_images_for_common_member?
    user && user.common_member? && category.nil?
  end

  def verify_upload_images_for_advanced_member?
    errors.add(:transaction_id, "您最多可以上传5张图片") if transaction && transaction.user.advanced_member? && self.class.select(:transaction_id).where(transaction_id: transaction_id).size >= 5
  end

  def verify_upload_company_images_for_advanced_member?
    errors.add(:user_id, "您最多可以上传8张图片") if user && user.advanced_member? && category.nil? && self.class.select([:user_id, :category]).where(user_id: user_id, category: nil).size >= 8
  end

  def verify_upload_license_images
    license_picture?
  end


end
