require 'spec_acceptance_helper'

describe 'tool installation' do
  CMDS = ['/usr/bin/geoipupdate', '/usr/bin/mmdblookup'].freeze

  CMDS.each do |cmd|
    describe file(cmd) do
      it { is_expected.to exist }
      it { is_expected.to be_file }
      it { is_expected.to be_executable }
      its(:size) { is_expected.to be > 0 }
    end
  end
end
