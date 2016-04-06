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
puts os[:family]

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
  when (1..6.9)
    raise "SystemD is unsupported on this platform: #{os[:family]} #{os[:release]}"
  when 7
    journald_pkgname = 'systemd'
  #when 19 # Fedora
  #  docker_pkgname = 'docker-io'
  end
when 'ubuntu'
  package_manager = 'apt'
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
  #docker_pkgname = 'docker.io'
end

describe package(journald_pkgname) do
  it { should be_installed }
end

describe file("/etc/systemd/journald.conf") do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_executable 'root' }
end

#describe command('sudo docker ps') do
#  its(:stdout) { should match /^CONTAINER ID\s+IMAGE\s+COMMAND\s+CREATED\s+STATUS\s+PORTS\s+NAMES$/ }
#  its(:exit_status) { should eq 0 }
#end

#describe command('sudo docker pull stackbrew/busybox') do
#  its(:stdout) { should match /Pulling.*stackbrew\/busybox/ }
#  its(:exit_status) { should eq 0 }
#end

#describe command('sudo docker run -d stackbrew/busybox /bin/sh -c "while true; do echo Hello world; sleep 5; done"') do
#  its(:stdout) { should match /[a-fA-F0-9]{64}/ }
#  its(:exit_status) { should eq 0 }
#end

#describe command('sudo docker ps') do
#  its(:stdout) { should match /[a-fA-F0-9]{12}\s+stackbrew\/busybox.+?\s+.*\/bin\/sh -c 'while t(.*)$/ }
#  its(:exit_status) { should eq 0 }
#end

# describe file('/usr/local/lib/docker') do
#   it { should be_directory }
#   it { should be_executable }
#   it { should be_executable.by('others') }
#   it { should be_owned_by 'root' }
#   it { should be_grouped_into 'root' }
# end

#describe file(docker_service_config) do
# it { should be_file }
# its(:content) { should match /^other_args=""$/ }
#end

#describe file(docker_storage_config) do
# it { should be_file }
# its(:content) { should match /^DOCKER_STORAGE_OPTIONS=""$/ }
#end

## Idempotency test
## Test that nothing changes when run 2nd time && state=present for critical pkgs
#describe command('ANSIBLE_ROLES_PATH=/tmp/kitchen/roles sudo -E ansible-playbook -i /tmp/kitchen/hosts -c local -M /tmp/kitchen/modules -vv  --diff /tmp/kitchen/default.yml') do
#  its(:stdout) { should match /changed=0.*failed=0/ }
#  its(:stdout) { should match Regexp.new("#{package_manager}.*name=docker.*state=present") }
#  its(:stdout) { should match Regexp.new("#{package_manager}.*name=device-mapper-libs.*state=latest") } if os[:family] == 'redhat'
#  its(:exit_status) { should eq 0 }
#end
