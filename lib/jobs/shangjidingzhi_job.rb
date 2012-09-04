class ShangjidingzhiJob < Struct.new(:users)
  def perform
    if users.kind_of?(Array) 
      users.each do |user|
        mailer = TransactionMailer.dingzhi(user)
        mailer.deliver
      end
    else
      mailer = TransactionMailer.dingzhi(users)
      mailer.deliver
    end
  end
end
