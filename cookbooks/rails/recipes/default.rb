include_recipe "nginx"
include_recipe "unicorn" 

gem_package "rails" # you don't need this if you are gonna grab the rails folder from git repository since the Gemfile in the app already has that gem in it so can just use bundle install
gem_package "bundler"

# might also need to add in package sqlite3 in addition to line below 
package "libsqlite3-dev"

#gem_package "sqlite3" # you probably don't need this either.. same as reason above for rails 

# but to install the new version - 
# add-apt-repository ppa:chris-lea/node.js
#apt-get -y update
package "nodejs" 

bash "create_app" do 
  cwd "/home/ubuntu"
  code <<-EOH
  rails new #{node[:app][:name]}
  EOH
  not_if { File.exists?("/home/ubuntu/#{node[:app][:name]}") }
end 

bash "start_stop_webrick" do 
  cwd "/home/ubuntu/#{node[:app][:name]}"
  code <<-EOH
  rails s &
  EOH
  only_if { File.exists?("/home/ubuntu/#{node[:app][:name]}") }
end 

nginx_site "#{node[:app][:name]}"

# first start and stop the rails server using webrick so that necessary files for unicorn processes will be created

#bash "start_stop_webrick" do 
  #cwd "/home/ubuntu/#{node[:app][:name]}"
  #code <<-EOH
  #rails s
  #PID=$!
  #kill $PID 
  #EOH
#end 

unicorn_app "#{node[:app][:name]}" 

# install postgesql instead of sqlite3

# new app
# create a rails app 
# cd into that new app and run bundle install


# install git
# git clone an existing app from a repository
