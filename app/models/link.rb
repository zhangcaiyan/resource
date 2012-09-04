#coding: utf-8

class Link < ActiveRecord::Base
  belongs_to :user
  validates :url, presence: true, format: {with: RubyRegex::Url}
  validates :name, presence: true
end
