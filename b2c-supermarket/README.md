# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

## Notes
~~~shell
gem install mysql2 --platform=ruby -- --with-mysql-dir=D:\mysql-5.7.37-winx64\mysql-connector-c++-noinstall-1.1.13-winx64
rails db:create

rails g model product_image
rails db:migrate
rake db:rollback
~~~

~~~shell
rails generate sorcery:install user_activation remember_me --only-submodules
rails g rspec:install
rails g controller admin::categories new index

rails routes | grep `name`
~~~

~~~shell
brew install imagemagick
rails g migration add_product_images_index
~~~