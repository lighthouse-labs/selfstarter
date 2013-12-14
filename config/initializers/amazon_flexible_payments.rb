AmazonFlexPay.access_key = ENV["amazon_access_key"]
AmazonFlexPay.secret_key = ENV["amazon_secret_key"]
AmazonFlexPay.go_live! if Rails.env.production?