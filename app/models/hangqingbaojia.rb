class Hangqingbaojia < ActiveRecord::Base
  acts_as_taggable

  def self.search_by_title_or_tag(keyword)
    t1 = Hangqingbaojia.tagged_with(keyword, any: true, wild: true)
    t2 = Hangqingbaojia.search({title_like: keyword}).relation
    [t1 + t2].flatten.uniq.sort{|a, b| b.published_at <=> a.published_at}
  end
end
