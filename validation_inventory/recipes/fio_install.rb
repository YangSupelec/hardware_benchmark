#
# Cookbook:: validation_inventory
# Recipe:: fio_install
#
# Copyright:: 2017, The Authors, All Rights Reserved.

yum_package 'libaio'
# Download and install hwinfo for specific version
remote_file "#{Chef::Config['file_cache_path']}/fio_prepare.rpm" do
  source node['fio']['source_url']
  action :create_if_missing
  notifies :run, "bash[install_fio]", :immediately
end

bash "install_fio" do
	cwd Chef::Config['file_cache_path']
	code <<-EOH
		sudo yum install fio_prepare*rpm -y
		sudo yum install fio -y
	EOH
 	action :nothing
end