
filename = node[:elasticsearch][:deb_url].split('/').last
remote_file "tmp/#{filename}" do
  source node[:elasticsearch][:deb_url]
  checksum node[:elasticsearch][:deb_sha]
  mode 00644
end

dpkg_package "tmp/#{filename}" do
  action :install
end

service 'elasticsearch' do
  supports :status => true
  action [ :enable, :start ]
end
