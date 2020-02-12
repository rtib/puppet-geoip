require 'spec_helper_acceptance'

describe 'geoip update' do
  describe 'systemd service' do
    subject(:systemd_unit) { run_shell('systemctl start geoip_update.service') }

    its(:exit_code) { is_expected.to eq 0 }
  end

  describe 'geoipupdate command' do
    subject(:update_tool) { run_shell('geoipupdate -v') }

    its(:exit_code) { is_expected.to eq 0 }
  end
end
