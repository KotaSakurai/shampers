class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def default_url_options
    if Rails.env.production?
      {:host => "shampers.info"}
    else
      {}
    end
  end
end
