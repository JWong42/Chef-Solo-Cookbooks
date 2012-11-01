define :unicorn_app do 

  unicorn_app_config_path = "/home/ubuntu/#{params[:name]}/config"

  template "#{unicorn_app_config_path}/unicorn.rb" do 
    mode 0755
	cookbook "unicorn"
    source "unicorn.erb"
  end 

  template "#{unicorn_app_config_path}/unicorn_init.sh" do 
    mode 0755
	cookbook "unicorn"
    source "unicorn_init.erb"
    notifies :reload, "service[nginx]"
  end 

  link "/etc/init.d/unicorn" do 
    to "#{unicorn_app_config_path}/unicorn_init.sh"
  end 

  directory "/home/ubuntu/#{params[:name]}/tmp/pids/" do
    mode 0777
  end 

  service "unicorn" do 
    supports :status => true, :restart => true, :reload => true
    action [:enable, :start]
  end 

end 
