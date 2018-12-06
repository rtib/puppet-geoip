require 'spec_acceptance_helper'

describe 'geoip update' do
  describe 'systemd service' do
    subject(:systemd_unit) { command('systemctl start geoip_update.service') }

    its(:exit_status) { should eq 0 }
  end

  describe 'geoipupdate command' do
    subject(:systemd_unit) { command('geoipupdate -v') }

    its(:exit_status) { should eq 0 }
  end
  
end
