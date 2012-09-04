class Setting::Smtp < Settingslogic
  source "#{Rails.root}/config/smtp.yml"
  namespace Rails.env
end
