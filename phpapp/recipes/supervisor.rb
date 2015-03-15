node[:deploy].each do |app_name, deploy|
  
  script "supervisor_install" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    sudo apt-get install supervisor
    service supervisor restart
    EOH
  end
  
  
  
end
end
