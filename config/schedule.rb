# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron



every 1.day, at: '3:30 am' do
  runner "CompanyPrice.verify_expired"  # 将过期的报价信息设置为无效
end

every 1.day, :at => '4:00 am' do 
  runner "Transaction.verify_expired"  # 将过期的交易信息设置为无效
end

every 1.day, :at => '4:30 am' do 
  runner "Shangjidingzhi.start_job"  # 发送用户定制的邮件
end

every 1.day, :at => '5:00 am' do 
  runner "Attachment.delete_invalid_images"  # 删除无效的图片
end










# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
