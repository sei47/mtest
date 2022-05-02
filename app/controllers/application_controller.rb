class ApplicationController < ActionController::Base
  before_action :basic_auth if Rails.env.production?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['username'] && password == ENV['password']
    end
  end
end
