# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# raise_delivery_errors = true
# ActionMailer::Base.raise_delivery_errors = true
# ActionMailer::Base.delivery_method = :smtp
# host = 'shampers.herokuapp.com'
# ActionMailer::Base.default_url_options = { host: host }
# # config.action_mailer.raise_delivery_errors = true
# # config.action_mailer.delivery_method = :smtp

# # config.action_mailer.default_url_options = { host: host }
# ActionMailer::Base.smtp_settings = {
#   :address        => 'smtp.sendgrid.net',
#   :port           => '587',
#   :authentication => :plain,
#   :user_name      => ENV['SENDGRID_USERNAME'],
#   :password       => ENV['SENDGRID_PASSWORD'],
#   :domain         => 'heroku.com',
#   :enable_starttls_auto => true
# }
