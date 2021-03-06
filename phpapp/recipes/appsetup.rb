node[:deploy].each do |app_name, deploy|
  script "install_composer" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    curl -sS https://getcomposer.org/installer | php
    php composer.phar install --no-dev
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
