#coding: utf-8

class Dongtai < Hangqingbaojia

  extend ActiveHash::Associations::ActiveRecordExtensions
  
  validates_presence_of :title, :resource_id, :region_id, :published_at

  belongs_to_active_hash :resource, class_name: "KeyValues::Resource"
  belongs_to_active_hash :region, class_name: "KeyValues::DongtaiCategory"

  scope :jinshu, where(resource_id: 1)
  scope :suliao, where(resource_id: 2)
  scope :zhi, where(resource_id: 3)

  def pre?
    id != self.class.first.id
  end

  def next?
    id != self.class.last.id
  end

  def pre
    self.class.where("id < ?", id).order("id DESC").limit(1).last
  end

  def next
    self.class.where("id > ?", id).limit(1).first
  end
end
