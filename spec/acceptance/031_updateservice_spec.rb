require 'spec_helper_acceptance'

describe 'systemd service for update' do
  subject(:systemd_unit) { run_shell("systemctl start #{service_name}.service") }

  its(:exit_code) { is_expected.to eq 0 }
end
