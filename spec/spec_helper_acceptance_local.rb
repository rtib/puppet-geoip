# frozen_string_literal: true

include PuppetLitmus

# constants
DBS = ['GeoLite2-ASN', 'GeoLite2-Country', 'GeoLite2-City'].freeze
CONFIG_GE311 = false # default

node_facts = facts_from_node(inventory_hash_from_inventory_file, ENV['TARGET_HOST']) || {}
if node_facts['platform'] =~ %r{debian}
  run_shell('cat /etc/apt/sources.list | cut -d" " -f-3 | sed "s/$/ contrib non-free/g" > /etc/apt/sources.list.d/extra.list')
  run_shell('apt-get update')
  if node_facts['platform'] =~ %r{debian:10}
    CONFIG_GE311 = true
  end
end
