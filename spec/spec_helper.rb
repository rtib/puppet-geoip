require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'

include RspecPuppetFacts

puts "Spec helper is: " + __FILE__
puts "Hiera path is: " + File.expand_path(File.join(__FILE__, '../fixtures/hiera.yaml'))

RSpec.configure do |c|
  c.hiera_config = File.expand_path(File.join(__FILE__, '../fixtures/hiera.yaml'))
  c.after(:suite) do
    RSpec::Puppet::Coverage.report!
  end
end
