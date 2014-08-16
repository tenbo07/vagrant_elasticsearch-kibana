#
# Cookbook Name:: td-agent
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "td-agent"

%w{curl libcurl3 libcurl4-openssl-dev}.each do |pkg|
  package pkg do
   action :install
  end
end

td_agent_gem "elasticsearch" do
  plugin true
end

template '/etc/td-agent/td-agent.conf' do
  source 'td-agent.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
