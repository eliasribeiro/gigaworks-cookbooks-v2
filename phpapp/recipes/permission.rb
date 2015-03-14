node[:deploy].each do |app_name, deploy|
	if platform_family?('debian')
		execute "set permissions for /srv/www" do
		command "sudo chmod 0777 -Rf /srv/www"
	  end
	end
end
