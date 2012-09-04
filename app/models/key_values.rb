#coding: utf-8

module KeyValues

  class Resource < ActiveHash::Base
    include ActiveHash::Associations

    self.data = [
      {id: 1, name: "废金属"},
      {id: 2, name: "废塑料"},
      {id: 3, name: "废纸"},
      {id: 4, name: "废橡胶"}
    ]

    has_many :price_categories, class_name: "KeyValues::PriceCategory", foreign_key: "resource_id"
    has_many :hangqings
    has_many :dongtais
    has_many :jiages
    has_many :hangqingbaojias
    has_many :comments

  end

  class PriceCategory < ActiveHash::Base
    include ActiveHash::Associations

    self.data = [
      {id: 1, name: "废铜", resource_id: 1},
      {id: 2, name: "废铝", resource_id: 1},
      {id: 3, name: "废铁", resource_id: 1},
      {id: 4, name: "废铅废锌", resource_id: 1},
      {id: 5, name: "废不锈钢", resource_id: 1},
      {id: 6, name: "废钢", resource_id: 1},
      {id: 7, name: "国外废金属", resource_id: 1},
      {id: 8, name: "废镍", resource_id: 1},
      {id: 9, name: "废钼", resource_id: 1},
      {id: 10, name: "废钛", resource_id: 1},
      {id: 11, name: "废料", resource_id: 1},
      {id: 12, name: "废金属", resource_id: 1},
      {id: 13, name: "废电瓶", resource_id: 1},

      {id: 14, name: "PET", resource_id: 2},
      {id: 15, name: "PP", resource_id: 2},
      {id: 16, name: "LDPE", resource_id: 2},
      {id: 17, name: "PC", resource_id: 2},
      {id: 18, name: "PS", resource_id: 2},
      {id: 19, name: "HDPE", resource_id: 2},
      {id: 20, name: "ABS", resource_id: 2},
      {id: 21, name: "PVC", resource_id: 2},
      {id: 22, name: "PA", resource_id: 2},
      {id: 23, name: "PMMA", resource_id: 2},
      {id: 24, name: "POM", resource_id: 2},

      {id: 25, name: "废纸价格", resource_id: 3},
      {id: 26, name: "国内欧废", resource_id: 3},
      {id: 27, name: "国内日废", resource_id: 3},
      {id: 28, name: "国内美废", resource_id: 3},
      {id: 29, name: "国外废纸", resource_id: 3},
      {id: 30, name: "湖南汨罗废纸", resource_id: 3},

      {id: 31, name: "国内橡胶", resource_id: 4},
      {id: 32, name: "国外橡胶", resource_id: 4}
    ]
    belongs_to :resource, class_name: "KeyValues::Resource"
    has_many :jiages, foreign_key: :category_id
  end

  class DongtaiCategory < ActiveHash::Base

    include ActiveHash::Associations

    has_many :dongtais, class_name: "Dongtai", foreign_key: :region_id

    self.data = [
      {id: 1, name: "广东"},
      {id: 2, name: "浙江"},
      {id: 3, name: "江苏"},
      {id: 4, name: "山东"},
      {id: 5, name: "天津"},
      {id: 6, name: "河北"},
      {id: 7, name: "上海"},
      {id: 8, name: "福建"},
      {id: 9, name: "湖南"},
      {id: 10, name: "湖北"},
      {id: 11, name: "北京"},
      {id: 12, name: "安徽"},
      {id: 13, name: "重庆"},
      {id: 14, name: "江西"},
      {id: 15, name: "河南"},
      {id: 16, name: "内蒙"},
      {id: 17, name: "新疆"},
      {id: 18, name: "宁夏"},
      {id: 19, name: "西藏"},
      {id: 20, name: "海南"},
      {id: 21, name: "广西"},
      {id: 22, name: "四川"},
      {id: 23, name: "贵州"},
      {id: 24, name: "山西"},
      {id: 25, name: "云南"},
      {id: 26, name: "辽宁"},
      {id: 27, name: "陕西"},
      {id: 28, name: "吉林"},
      {id: 29, name: "甘肃"},
      {id: 30, name: "黑龙江"},
      {id: 31, name: "青海"},
      {id: 32, name: "香港"},
      {id: 33, name: "澳门"},
      {id: 34, name: "台湾"}
    ]
  end

end
