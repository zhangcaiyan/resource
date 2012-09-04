# coding: utf-8
namespace :load do

  task :users => :environment do  # 添充数据 
    20.times do
      user = Setting::User.user
      if !User.exists?(:email => user.email)
        user=User.create(user) 
        user.admin = [true, false].at(rand(2))
        user.save
        User.confirm_by_token(user.confirmation_token)
      end
      Setting::User.reload!
    end
    puts "填充普通用户数据结束"
  end

end

