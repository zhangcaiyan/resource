#coding: utf-8

class TransactionMailer < ActionMailer::Base
  default from: "#{App::NAME} <#{Setting::Smtp['config']['user_name']}>"

  def dingzhi(user) 
    @host = Setting::Smtp['host']['host_only']
    @port = Setting::Smtp['host']['port_only']
    @user = user 
    mail(to: user.valid_email, subject: App::NAME) 
  end
end
