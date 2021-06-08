# frozen_string_literal: true
require 'rspec-puppet-facts'
include RspecPuppetFacts

TEST_CONFIG_LT311 = {
  'config' => {
    'userid'     => '999999',
    'licensekey' => '000000000000',
  },
}.freeze

TEST_CONFIG_GE311 = {
  'config' => {
    'accountid'  => '999999',
    'licensekey' => '000000000000',
  },
}.freeze

def default_config(os)
  config_for(os)[:config]
end

def config_for(os)
  case os
  when 'debian-10-x86_64'
    { name: '>= 3.1.1', class: 'ge311', config: TEST_CONFIG_GE311 }
  else
    { name: '< 3.1.1', class: 'lt311', config: TEST_CONFIG_LT311 }
  end
end

add_custom_fact :systemd_version, ->(os, facts) {
  case facts[:os]['family']
  when /(redhat|centos)-7-x86_64/
    219
  when /(redhat|centos)-8-x86_64/
    239
  else
    240
  end
}
