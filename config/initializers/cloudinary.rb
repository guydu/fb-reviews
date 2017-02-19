Cloudinary.config do |config|
  config.cloud_name = Rails.application.secrets.cloud_name
  config.api_key = Rails.application.secrets.api_key
  config.api_secret = Rails.application.secrets.api_secret
  config.cdn_subdomain = true
end