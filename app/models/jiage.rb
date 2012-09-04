# coding: utf-8

class Jiage < Hangqingbaojia

  extend ActiveHash::Associations::ActiveRecordExtensions

  validates_presence_of :title, :resource_id, :category_id, :published_at

  belongs_to_active_hash :resource, class_name: "KeyValues::Resource"
  belongs_to_active_hash :category, class_name: "KeyValues::PriceCategory"

  scope :jinshu, where(resource_id: 1)
  scope :suliao, where(resource_id: 2)
  scope :zhi, where(resource_id: 3)
  scope :xiangjiao, where(resource_id: 4)

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
