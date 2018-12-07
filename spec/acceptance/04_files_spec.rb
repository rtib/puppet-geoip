require 'spec_acceptance_helper'

describe 'check database files' do
  DBS = ['GeoLite2-Country', 'GeoLite2-City'].freeze

  DBS.each do |db|
    describe file("/var/lib/GeoIP/#{db}.mmdb") do
      it { is_expected.to exist }
      it { is_expected.to be_file }
      it { is_expected.to be_readable }
      its(:size) { is_expected.to be > 0 }
    end
  end
end
