require 'spec_helper'

describe 'geoip' do
  describe 'geoip::config' do
    on_supported_os.each do |os, default_facts|
      context "on #{os}" do
        let(:facts) do
          default_facts
        end

        describe 'geoipupdate < 3.1.1' do
          let(:params) do
            {
              'config' => {
                'userid'     => '999999',
                'licensekey' => '000000000000',
              },
            }
          end

          it { is_expected.to contain_class('geoip::config::lt311') }
        end
      end
    end # on_supported_os.each
  end
end # describe 'geoip'
