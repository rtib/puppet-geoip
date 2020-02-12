# frozen_string_literal: true

include PuppetLitmus

DBS = ['GeoLite2-Country', 'GeoLite2-City'].freeze

# node_vars = vars_from_node(inventory_hash_from_inventory_file, ENV['TARGET_HOST']) || {}

# if node_vars.key?('apt_sources_list')
#  bolt_upload_file(File.join(File.dirname(__FILE__), 'fixtures', node_vars['apt_sources_list']), '/etc/apt/sources.list.d/cassandra.sources.list')
#  run_shell('apt-get update')
# end

run_shell('cat /etc/apt/sources.list | cut -d" " -f-3 | sed "s/$/ contrib non-free/g" > /etc/apt/sources.list.d/extra.list')
run_shell('apt-get update')
