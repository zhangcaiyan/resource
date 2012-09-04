#coding: utf-8

class Message < ActiveRecord::Base

  has_ancestry

  default_value_for :is_from_deleted, false
  default_value_for :is_to_deleted, false
  default_value_for :is_from_soft_deleted, false
  default_value_for :is_to_soft_deleted, false
  default_value_for :is_read, false

  belongs_to :sender, foreign_key: :from_id, class_name: "User"
  belongs_to :addressee, foreign_key: :to_id, class_name: "User"
  belongs_to :message_type

  validates :title, presence: true, length: {maximum: 100}
  validates :desc, presence: true, length: {maximum: 1500}
  validates :from_id, presence: true
  validates :to_id, presence: true
  validate :verify_sender

  scope :unread, where({is_read: false})

  protected

  def verify_sender
    errors.add(:base, "发件人和收件人不能是同一人") if from_id == to_id
  end
  
  def self.shanchu(user, category, delete_type, message_ids) 
    if(category == "receive")
      messages = user.receive_messages.where(id: message_ids)
      if delete_type == "soft_delete"
        messages.update_all(is_to_soft_deleted: true)
      elsif delete_type == "delete"
        messages.update_all(is_to_deleted: true)
      end
    elsif(category == "send")
      messages = user.send_messages.where(id: message_ids)
      if delete_type == "soft_delete"
        messages.update_all(is_from_soft_deleted: true)
      elsif delete_type == "delete"
        messages.update_all(is_from_deleted: true)
      end
    else
      messages = user.deleted_messages.where(id: message_ids)
      messages.each do |message|
        if message.sender == user
          message.update_attribute("is_from_deleted", true)
        else
          message.update_attribute("is_to_deleted", true)
        end
      end
    end
  end

  def self.huifu(user, message_ids)
    messages = user.deleted_messages.where(id: message_ids)
    messages.each do |message|
      if message.sender == user
        message.update_attribute("is_from_soft_deleted", false)
      else
        message.update_attribute("is_to_soft_deleted", false)
      end
    end
  end
  
end
