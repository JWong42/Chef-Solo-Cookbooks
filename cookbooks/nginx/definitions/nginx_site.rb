define :nginx_site do 

  nginx_rails_config_path = "/home/ubuntu/#{params[:name]}/config/nginx.conf"
  nginx_site_config_path  = "/etc/nginx/sites-enabled/#{params[:name]}"

  template nginx_rails_config_path do 
    mode 0644
	cookbook "nginx"
    source "unicorn-site.erb"
  end

  link nginx_site_config_path  do 
    to nginx_rails_config_path 
    notifies :reload, "service[nginx]"
  end 

  file "/etc/nginx/sites-enabled/default" do 
    action :delete
  end 

end  

	
