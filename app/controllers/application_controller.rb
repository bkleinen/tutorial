require 'sessions_helper'
class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
end


