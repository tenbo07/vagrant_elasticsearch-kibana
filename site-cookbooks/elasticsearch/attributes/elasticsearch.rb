default[:elasticsearch][:deb_url] = "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.1.deb"
default[:elasticsearch][:deb_sha] = "1910a5df82f1c9652f48d9a8f93ae880acc1db81dbab8d7aa70511af6199a62f"

default[:elasticsearch][:setting] = {
  "index.number_of_shards" => "1",
  "index.number_of_replicas" => "0",
  "path.conf" => "/etc/elasticsearch",
  "path.data" => "/data",
  "path.logs" => "/var/log/elasticsearch",
  "script.disable_dynamic" => "false"
}
