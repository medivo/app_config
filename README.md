app_config
==========

AppConfig is a gem that allows you to create an config/app_config.yml file in a Rails project and access the keys and values as a hash throughout the project.

This gem is excellent for storing Rails-wide constants.

The App constants should be stored in one or both of the following files (exact filenames are required):
config/app_config_default.yml
config/app_config.yml

The AppConfig app should be loaded in the initializers directory.  Here is an example file:
```ruby
#config/initializers/app_config.rb
require "app_config"

AppConfig.reload(Rails.env, Rails.root)
```

Here is an example of what the config/app_config.yml can look like:
```yaml
defaults: &default
  gmail:
    email: "bob@example.com"
    password: "something"
```

There are two methods to access the email:
```ruby
#Normal method
AppConfig['gmail']['email']
#Shortcut method
GmailConfig['email']
```

The shorcut method only works one level deep.
