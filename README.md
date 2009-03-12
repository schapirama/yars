# YARS: YARS is Another Rails Skeleton

YARS is a skeleton of a Rails app pre-initialized with a convenient set of plugins, libraries, controllers & views. It also contains 
a modified scaffold generator that creates much simpler (non-RESTful!) controllers and views. 

## Install

Simply clone this repository to start a new Rails App. Then 

* Edit <code>config/database.yml</code>
* Edit ActionMailer, ExceptionNotifier, and SYSTEM_NAME setups in <code>config/environment.rb</code>
* Run <code>rake db:migrate</code>
* If you want, edit <code>public/stylesheets/application.css</code> (but not blueprint, so we can upgrade it later if necessary)

## Packages Included

### Plugins

 * [acts_as_taggable_on_steroids](http://agilewebdevelopment.com/plugins/acts_as_taggable_on_steroids)
 * [file_column](http://www.kanthak.net/opensource/file_column/)
 * [will_paginate](http://github.com/mislav/will_paginate/tree/master)
 * [exception_notification](http://github.com/rails/exception_notification/tree/master)
 * [action_mailer_tls](http://github.com/openrain/action_mailer_tls/tree/master)
 * [restful_authentication](http://github.com/technoweenie/restful-authentication/tree/master)
 * [role_requirement](http://code.google.com/p/rolerequirement/)
 * [better_nested_set](http://opensource.symetrie.com/trac/better_nested_set/)
 * [ssl_requirement](http://github.com/rails/ssl_requirement/tree/master)
 * [BackgroundJob (BJ)](http://codeforpeople.rubyforge.org/svn/bj/trunk/README)
 * [assert_valid_markup](http://github.com/wireframe/assert_valid_markup/)

### CSS

 * [blueprint](http://www.blueprint.org)


## Added/changed behaviors

### Scaffold Generator

     $ ruby script/generate scaffold Model field1:type field2:type

 * Generates simple controller with four methods: _index_, _new_, _edit_, _delete_
 * _new_ and _edit_ handle GET requests to display the form, and POST requests to process it
 * All actions redirect back to _index_
 * Two simple views: _edit_, and _index_

### Restful_Authentication

 * Modified so that users are *only* identified by _email_ and _password_ (not by _username / login_). 
 * Added method to _change_password_ (<code>/change_password</code>)
 * Added method to retrieve forgotten password (<code>/amnesia</code>). The method allows the user to specify a new password, which is
   stored but doesn't automatically replace the current password. An email is sent to the user's address with a link to confirm the change.
   When the link is followed, the newly set password replaced the old one, and the user is redirected again to the login page.
 * Sends link to confirm password change in the background, using [BackgroundJob (BJ)](http://codeforpeople.rubyforge.org/svn/bj/trunk/README). 
   See <code>jobs/email_changed_pwd.rb</code>
 * Requires SSL for login and signup

### Roles

 
  * Added default roles _admin_ and _user_
  * When a new account is created via Restful_Authentication, it makes it by default be a _user_

### ssl_requirement

  * Use by specifying <code>ssl_required</code> in your controller (and specify actions if necessary)
  * Turned off by default in development mode (see <code>ApplicationController</code>)

### Layout

  * Uses [blueprint](http://www.blueprint.org) to create basic grid. 
  * Header has _SYSTEM_NAME_ (defined in <code>environment.rb</code>), and links to _Log In/Out_ and _Sign Up_
  * Footer shows _AUTHOR_NAME_ with link to _AUTHOR_URL_ (defined in <code>environment.rb</code>)

### ActionMailer

 * Setup to use [action_mailer_tls](http://github.com/openrain/action_mailer_tls/tree/master), so that it sends email via GMail.
 * See <code>UsersController/amnesia</code> and <code>jobs/email_changed_pwd.rb</code> to get an idea of how to send email in the background.

## Details

See DETAILS.md file for more information about the setup of each plugin.
