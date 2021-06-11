require 'spec_helper_acceptance'

describe 'check database files' do
  DBS.each do |db|
    describe file("/usr/local/share/GeoIP/#{db}.mmdb") do
      it { is_expected.to exist }
      it { is_expected.to be_file }
      it { is_expected.to be_readable }
      its(:size) { is_expected.to be > 0 }
    end
  end
end
