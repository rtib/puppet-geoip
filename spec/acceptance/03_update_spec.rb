require 'spec_helper_acceptance'

describe 'geoip update' do
  describe 'systemd service' do
    subject(:systemd_unit) { command('systemctl start geoip_update.service') }

    its(:exit_status) { is_expected.to eq 0 }
  end

  describe 'geoipupdate command' do
    subject(:update_tool) { command('geoipupdate -v') }

    its(:exit_status) { is_expected.to eq 0 }
  end
end
