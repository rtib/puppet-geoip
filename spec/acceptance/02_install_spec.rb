require 'spec_acceptance_helper'

describe 'tool installation' do
  describe file('/usr/bin/geoipupdate') do
    it { is_expected.to exist }
    it { is_expected.to be_file }
    it { is_expected.to be_executable }
    its(:size) { is_expected.to be > 0 }
  end
  describe file('/usr/bin/mmdblookup') do
    it { is_expected.to exist }
    it { is_expected.to be_file }
    it { is_expected.to be_executable }
    its(:size) { is_expected.to be > 0 }
  end
end
