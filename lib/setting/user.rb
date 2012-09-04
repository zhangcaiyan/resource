class Setting::User < Settingslogic
  source "#{Rails.root}/config/user.yml"
  namespace Rails.env
end
