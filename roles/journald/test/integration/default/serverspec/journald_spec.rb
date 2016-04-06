require 'spec_helper'

# Hack to detect OS version at test-kitchen verify time
## Note: This was in ServerSpec v1
# Specinfra::Helper::DetectOS.commands
# os = Specinfra::Helper::Properties.property[:os_by_host]['localhost']

# New way is much cleaner!! Only need 1 line in spec_helper.rb!
# References:
#  - http://chocksaway.com/blog/?p=513
#  - http://serverspec.org/changes-of-v2.html
# Debug:
# puts Specinfra::Helper::Os.os

# Check the right package name depending on OS
case os[:family]
when 'redhat'
  #docker_service_config = '/etc/sysconfig/docker'
  #docker_storage_config = '/etc/sysconfig/docker-storage'
  package_manager = 'yum'
  case os[:release].to_f
  #when 5.10
  #  docker_pkgname = 'docker-io'
  #when 6.4
  #  docker_pkgname = 'docker-io'
  #when 6.5
  #  docker_pkgname = 'docker-io'
  when (1..6.9)
    raise "SystemD is unsupported on this platform: #{os[:family]} #{os[:release]}"
  when (7..Float::INFINITY)
    journald_pkgname = 'systemd'
  #when 19 # Fedora
  #  docker_pkgname = 'docker-io'
  end
when 'ubuntu'
  package_manager = 'apt'
  journald_pkgname = 'systemd'
  #docker_service_config = '/etc/default/docker'
  #docker_storage_config = '/etc/default/docker-storage'
  journald_pkgname = 'systemd'

  #if system('apt-cache search docker.io | grep -qi container')
  #  docker_pkgname = 'docker.io'
  #else
  #  docker_pkgname = 'docker-engine'
  #end
when 'debian'
  package_manager = 'apt'
  journald_pkgname = 'systemd'
  #docker_service_config = '/etc/sysconfig/docker'
  #docker_storage_config = '/etc/sysconfig/docker-storage'
end

## Gather test-kitchen file path & Read test fixture vars
require 'pathname'
require 'yaml'

test_fixture_vars_file = Pathname.new(__FILE__).dirname.join('fixtures', 'defaults.yml')
fixture_vars = YAML.load(File.open(test_fixture_vars_file, 'r').read)
config_regexes = []

fixture_vars['journald_conf_settings'].each do |key, value|
  config_regexes.push( Regexp.new( "^#{ key.split('_').map{|k|  k.capitalize }.join('') }=#{ value }$" ) )
end

describe package(journald_pkgname) do
  it { should be_installed }
end

describe file("/etc/systemd/journald.conf") do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
  it { should be_readable.by('others') }
  config_regexes.each do |regex_line|
    its(:content) { should match regex_line }
  end
end
