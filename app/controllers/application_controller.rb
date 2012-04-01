class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper 
  #by default all helpers are included in views. This include adds
  #the Sessions helper to all controllers as they all inherit the 
  #ApplicationController, therefore Sessions becomes usable everywhere.
end
