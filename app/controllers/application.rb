# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  layout proc{ |c| c.request.xhr? ? false : "application" }

  # AuthenticatedSystem and RoleRequirementSystem
  include AuthenticatedSystem
  include RoleRequirementSystem
  include SslRequirement
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'f1395039b8a3160bf594189e17f3dbf2'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password
  
  # To work with exception_notification plugin (http://github.com/rails/exception_notification/tree/master)
  include ExceptionNotifiable
  local_addresses.clear

  def ssl_required?
    return false if RAILS_ENV != 'production'
    super
  end
  
end

