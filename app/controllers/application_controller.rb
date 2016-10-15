# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate

protected

  def set_start_time
    @start_time = Time.now.to_f
  end
  
  def authenticate
    set_start_time
    authenticate_or_request_with_http_basic do |username, password|
     @staff_login=Auth.where("user=?",username)[0]
      !@staff_login.nil? && @staff_login.password==Digest::MD5.hexdigest(password)
    end
  end

end
#