require 'spec_helper_acceptance'

describe 'geoipupdate command' do
  subject(:update_tool) { run_shell('geoipupdate -v') }

  its(:exit_code) { is_expected.to eq 0 }
end
