#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

apache_pkg_name = ""
conf_dir = ""
httpd_conf_path = ""
apache2_site_available = ""
template_name = ""
log_dir = ""
case node['platform']
when "ubuntu"
  apache_pkg_name = "apache2"
  conf_dir = "/etc/apache2"
  httpd_conf_path = "#{conf_dir}/apache2.conf"
  template_name = "apache2.conf.erb"
  log_dir = "/var/log/apache2"
  apache2_site_available = "/etc/apache2/sites-available/default"
when "centos", "redhat", "amazon"
  apache_pkg_name = "httpd"
  conf_dir = "/etc/httpd"
  httpd_conf_path = "#{conf_dir}/conf/httpd.conf"
  template_name = "httpd.conf.erb"
  log_dir = "/var/log/httpd"
end

package apache_pkg_name do
 action :install
end

template httpd_conf_path do
  source template_name
  owner 'root'
  group 'root'
  mode '0644'
end

directory conf_dir do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

if node['platform'] == "ubuntu" then
  template apache2_site_available do
    source 'sites-available.default.erb'
    owner 'root'
    group 'root'
    mode '0644'
  end
end

service apache_pkg_name do
  supports :status => true
  action [ :enable, :restart ]
end

execute 'add mode x' do
  not_if "test `stat -c '%a' #{log_dir}` -eq '755'"
  command "chmod -R 755 #{log_dir}"
  action :run
end
