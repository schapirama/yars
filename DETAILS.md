
# General Changes

Started in the usual way:

      $ rails yars

 * Setup <code>config/database.yml</code> setup to use MySQL
 * Removed <code>public/index.html</code>, <code>rails.png</code>
 * Added <code>filter_paramter_logging :password</code> to <code>Application Controller</code>
 * Setup ActionMailer to work with GMail, following [this tutorial](http://guides.rails.info/action_mailer_basics.html)
 * Installed [BluePrint CSS framework](http://www.blueprintcss.org/)

# Setup of Plugins

## [acts_as_taggable_on_steroids](http://agilewebdevelopment.com/plugins/acts_as_taggable_on_steroids)

	$ ruby script/plugin install http://svn.viney.net.nz/things/rails/plugins/acts_as_taggable_on_steroids
	$ ruby script/generate acts_as_taggable_migration

## [file_column](http://www.kanthak.net/opensource/file_column/)

	$ ruby script/plugin install http://opensvn.csie.org/rails_file_column/plugins/file_column/trunk

* fixed <code>vendor/plugins/lib/file_column.rb</code>, replace <code>Inflector</code> with <code>ActiveSupport::Inflector</code> (to work with 2.2.2)
				
## [will_paginate](http://github.com/mislav/will_paginate/tree/master)

	$ ruby script/plugin install git://github.com/mislav/will_paginate.git
		
## [exception_notification](http://github.com/rails/exception_notification/tree/master)
	$ ruby script/plugin install git://github.com/rails/exception_notification.git

* 	added <code>include ExceptionNotifiable</code> to <code>ApplicationController</code>
*	added <code>local_addresses.clear</code> to <code>ApplicationController</code>
*  	<code>added ExceptionNotifier.exception_recipients = %w(your email)</code> to <code>config/environment.rb</code>
*	[Note: works only in production mode]
	    
## [action_mailer_tls](http://github.com/openrain/action_mailer_tls/tree/master)

	$ ruby script/plugin install git://github.com/openrain/action_mailer_tls.git -r 'tag v1.0.0'
	
* added ActionMailer setup in <code>config/environment.rb</code>
		
## [restful_authentication](http://github.com/technoweenie/restful-authentication/tree/master) and [role_requirement](http://code.google.com/p/rolerequirement/)

	$ ruby script/plugin install git://github.com/technoweenie/restful-authentication.git
	$ ruby script/generate authenticated user sessions
	$ ruby script/plugin install git://github.com/timcharper/role_requirement.git
	$ ruby script/generate roles Role User
	$ ruby script/generate migration add_roles

* Created admin and user roles		
* moved <code>include AuthenticatedSystem</code> to <code>ApplicationController</code>
* removed login + email, left just email. Fixed views, controllers, tests, fixtures, etc. *BUT NOT ORIGINAL GENERATORS*
* cleaned up session controller and views, nicer interface
* Added <code>UserController::DEFAULT_ROLE</code>, automatically assign new users to it.
* Added <code>amnesia</code>, <code>change_password</code> handlers. Email notifier for reminders. 
		
## [better_nested_set](http://opensource.symetrie.com/trac/better_nested_set/)

	$ ruby script/plugin install http://opensource.symetrie.com/svn/better_nested_set/trunk

## [ssl_requirement](http://github.com/rails/ssl_requirement/tree/master)

	$ ruby script/plugin install git://github.com/rails/ssl_requirement.git

Note: Configure Apache to listen on port 443 (ports.conf), set config like:

        <VirtualHost *:443>
          ServerName yars.mongol
          SSLEngine on
          SSLCertificateFile /home/yars/config/ssl/skeleton.crt
          SSLCertificateKeyFile /home/yars/config/ssl/skeleton.key
          DocumentRoot /yars/public
        </VirtualHost>
        
See [here](http://www.buildingwebapps.com/articles/6401-using-ssl-in-rails-applications) for instructions on how to generate an SSL key

## [BackgroundJob (BJ)](http://codeforpeople.rubyforge.org/svn/bj/trunk/README)

	$ ruby script/plugin install http://codeforpeople.rubyforge.org/svn/rails/plugins/bj
	$ ruby script/bj setup
		
* Changed <code>Time.now</code> to <code>Time.now.utc</code> in all occurrences under <code>vendor/plugins/bj</code>
* Added directory <code>jobs/</code>
* Added <code>jobs/email_changed_pwd.rb</code> to send the email in the background
* Changed amnesia method to use BJ instead of sending the email in the controller's thread
* See [this article about sending emails in the background](http://overstimulate.com/articles/rails-bj-email)
		
## [assert_valid_markup](http://github.com/wireframe/assert_valid_markup/)
    $ ./script/plugin install git://github.com/wireframe/assert_valid_markup.git
    
* Includes modifications from http://blog.spotstory.com/category/plugin/ in test/test_markup_helper.rb


