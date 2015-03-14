node[:deploy].each do |app_name, deploy|
  script "install_composer" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current/vendor/laravel/framework/"
    code <<-EOH
    curl -s https://getcomposer.org/installer | php
    php composer.phar install
    EOH
  end

  script "set_permissions" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current/app"
    code <<-EOH
    chmod -R 777 storage
    EOH
  end
  
  if deploy[:application] == "platform"
   script "set_permissions" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current/app"
    code <<-EOH
    chmod -R 777 /srv/www
    EOH
  end
end
end
