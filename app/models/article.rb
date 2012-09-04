#coding: utf-8

class Article < ActiveRecord::Base

  before_save :verify_forum

  symbolize :category, in: [:hangye, :zhengce, :zaisheng, :zhishi], scopes: true, methods: true
  symbolize :fenlei, in: [:jinshu, :shuliao, :zhi, :qita], scopes: true, allow_blank: true
  symbolize :forum, in: [:common, :less_important, :important], scopes: true, methods: true

  validates :title, presence: true 
  validates :content, presence: true
  validates :fenlei, presence: true, if: lambda{|a| a.category == :hangye || a.category == :zaisheng }

  default_value_for :forum, :common

  def pre?
    id != self.class.send(category).first.id
  end

  def next?
    id != self.class.send(category).last.id
  end

  def pre
    self.class.where("id < ?", id).order("id DESC").limit(1).last
  end

  def next
    self.class.where("id > ?", id).limit(1).first
  end

  def guolv_content
    content.gsub(/<[^>]*>|&nbsp;|\r|\n|\t/, "")
  end

  def image_src
    img = content.match(/<img[^>]*>/).to_s
    if img.present?
      img.match(/src=\"([^\"]*)/)[1] 
    else
      "/assets/tu44.gif"
    end
  end

  def self.category_name(category)
    case category
    when "hangye" then "行业动态"
    when "zhengce" then "政策法规"
    when "zaisheng" then "再生技术"
    when "zhishi" then "知识宝库"
    end
  end

  def self.fenlei_name(fenlei)
    case fenlei
    when "jinshu" then "废金属"
    when "shuliao" then "废塑料"
    when "zhi" then "废纸"
    when "qita" then "其他"
    end
  end

  def self.first_important
    important.order("created_at DESC").limit(1).first
  end

  def self.second_important
    important.order("created_at DESC").offset(1).limit(1).first
  end

  def relation_articles
    if zhishi? || zhengce? || important?
      self.class.send(forum).send(category)
    else
      self.class.send(forum).send(category).send(fenlei)
    end
  end

  protected

  def verify_forum
    if important?
      articles = relation_articles.order("created_at DESC").offset(1)
      articles.each do |a|
        a.update_attribute(:forum, :common)
      end
    elsif less_important?
      relation_articles.update_all(forum: :common)
    end
  end
end
