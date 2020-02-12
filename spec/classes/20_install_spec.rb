require 'spec_helper'

describe 'geoip' do
  describe 'geoip::install' do
    on_supported_os.each do |os, default_facts|
      context "on #{os}" do
        let(:facts) do
          default_facts
        end

        let(:params) do
          {
            'config' => {
              'userid'     => '999999',
              'licensekey' => '000000000000',
            },
          }
        end

        it { is_expected.to contain_package('mmdb-bin').with_ensure('latest') }
        it { is_expected.to contain_package('geoipupdate').with_ensure('latest') }
      end
    end
  end
end
