# coding: utf-8

class Comment < ActiveRecord::Base

  extend ActiveHash::Associations::ActiveRecordExtensions

  acts_as_taggable

  symbolize :category, in: [:day, :week], scopes: true

  default_value_for :category, "day"
  default_value_for :resource_id, KeyValues::Resource.first.id

  validates_presence_of :title, :category, :resource_id, :published_at

  belongs_to_active_hash :resource, class_name: "KeyValues::Resource", foreign_key: :resource_id

  def pre?
    id != self.resource.comments.first.id
  end

  def next?
    id != self.resource.comments.last.id
  end

  def pre
    self.resource.comments.where("id < ?", id).order("id DESC").limit(1).last
  end

  def next
    self.resource.comments.where("id > ?", id).limit(1).first
  end 
  
end
