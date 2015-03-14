node[:deploy].each do |app_name, deploy|

  script "install_composer" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    curl -sS https://getcomposer.org/installer | php
    php composer.phar install --no-dev
    chmod -R 777 /srv/www
    EOH
  end
  
  script "set_permissions_laravel" do
    interpreter "bash"
    user "root"
    code <<-EOH
    chmod -R 777 /srv/www/
    EOH
  end
  
  if platform_family?('debian')
		execute "set permissions for #{deploy[:deploy_to]}/current/app/storage/" do
		command "sudo chmod 0777 -Rf #{deploy[:deploy_to]}/current/app/storage/"
	  end
	end
  
end
