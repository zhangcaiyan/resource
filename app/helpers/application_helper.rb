# coding: utf-8 

module ApplicationHelper

  def title(title)
    content_for :title do
      title + " - "
    end
  end

  def js(*js)
    content_for :head do
      javascript_include_tag *js
    end
  end

  def css(*css)
    content_for :head do
      stylesheet_link_tag *css
    end
  end

  def cn(model, attribute=nil)
    if attribute.present?
      t "activerecord.attributes.#{model}.#{attribute}"
    else
      t "activerecord.models.#{model}"
    end
  end

  def cns(model, attribute, value)
    t "activerecord.symbolizes.#{model}.#{attribute}.#{value}"
  end

  def my_path(options = {}) 
    if current_user.admin? 
      admin_url(options)
    else
      home_url(options)
    end
  end

  def cities
    region_id = params[:user].try(:[], :region_id)
    if region_id.present?  
      region = Region.find_by_id(region_id)
      region.cities.collect{|r| [r.name, r.id]}
    else
      current_user && current_user.region ? current_user.region.cities.collect{|r| [r.name, r.id]} : []
    end
  end

  def regions
    country_id = params[:user].try(:[], :country_id)
    if country_id.present?  
      country = Country.find_by_id(country_id)
      country.regions.collect{|c| [c.name, c.id]}
    else
      current_user && current_user.country ? current_user.country.regions.collect{|c| [c.name, c.id]} : []
    end
  end

  def customer_cities(customer)
    region_id = params[:customer].try(:[], :region_id)
    if region_id.present?  
      region = Region.find_by_id(region_id)
      region.cities
    else
      customer.region ? customer.region.cities : []
    end
  end

  def customer_regions(customer)
    country_id = params[:customer].try(:[], :country_id)
    if country_id.present?  
      country = Country.find_by_id(country_id)
      country.regions
    else
      customer.country ? customer.country.regions : []
    end
  end

  def send_message_link(user)
    link_to "留言", new_message_path(to_id: user) if (!current_user || current_user != user)
  end

  def is_self?(user)
    user_signed_in? && current_user == user
  end

  def default_image_tag(options = {})
    image_tag "/images/medium/missing.png", options
  end

  def register_image_tag(options = {})
    image_tag "/images/register.gif", options
  end

  def head_image(t, options = {})  # 交易信息和用户的第一张图片
    size = options[:size] || :thumb
    atta = t.attachments.first
    if atta
      image_tag atta.image.url(size), options
    else
      default_image_tag options   
    end
  end

  def website_path(user, options = {})
    if user.is_have_website?
      options[:subdomain] ||= user.username
      category = options[:category]
      if category.nil?
        member_home_url(options)
      elsif category == "message"
        member_message_url(options)
      elsif category == "contact"
        member_contact_url(options)
      elsif category == "transactions"
        member_transaction_url(options)
      elsif category == "show"
        member_show_url(options)
      end
    else
      home_user_path(user, options)
    end
  end


end
