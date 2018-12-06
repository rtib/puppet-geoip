require 'spec_acceptance_helper'

describe 'geoip database files' do
  describe file('/var/lib/GeoIP/GeoLite2-Country.mmdb') do
    it { is_expected.to exist }
    it { is_expected.to be_file }
    it { is_expected.to be_readable }
    its(:size) { is_expected.to be > 0 }
  end
  describe file('/var/lib/GeoIP/GeoLite2-City.mmdb') do
    it { is_expected.to exist }
    it { is_expected.to be_file }
    it { is_expected.to be_readable }
    its(:size) { is_expected.to be > 0 }
  end
end
