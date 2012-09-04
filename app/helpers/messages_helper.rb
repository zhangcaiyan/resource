#coding: utf-8

module MessagesHelper
  def mail_img(message)
    image_tag (message.is_read ? "mail_readed.gif" : "mail_un_readed.gif" ) if message.to_id == current_user.id
  end
end
