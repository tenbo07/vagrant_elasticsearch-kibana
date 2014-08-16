default[:td_agent][:apache][:tag] = "access_log"

default[:td_agent][:sources]={
  :apache_log =>{
    :type => "tail",
    :format => "json",
    :time_format => "%d/%b/%Y:%M:%S %z",
    :path => "/var/log/apache2/access.log"
  }
}

default[:td_agent][:match]={
  :elasticsearch =>{
    :type => "elasticsearch",
    :host => "192.168.33.10",
    :port => "9200",
    :type_name => "logs",
    :logstash_format => "true",
    :logstash_prefix => "apachelog",
    :flush_interval => "1",
    :include_tag_key => "true",
    :tag_key => "@log_name"
  }
}
