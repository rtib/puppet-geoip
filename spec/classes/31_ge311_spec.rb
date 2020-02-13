require 'spec_helper'

describe 'geoip' do
  on_supported_os.each do |os, default_facts|
    context "on #{os}" do
      let(:facts) do
        default_facts
      end

      describe 'geoip::config::ge311', if: config_for(os)[:class] == 'ge311' do
        let(:params) do
          default_config(os)
        end

        it do
          is_expected.to contain_file('/etc/GeoIP.conf')
            .with(
              'mode'  => '0640',
              'owner' => '0',
              'group' => '0',
            )
        end
        it do
          is_expected.to contain_file('/etc/GeoIP.conf')
            .with_content(%r{^AccountID 999999$})
        end
        it do
          is_expected.to contain_file('/etc/GeoIP.conf')
            .with_content(%r{^LicenseKey 000000000000$})
        end
        it do
          is_expected.to contain_file('/etc/GeoIP.conf')
            .with_content(%r{^EditionIDs GeoLite2-City GeoLite2-Country$})
        end
      end
    end # on_supported_os.each
  end
end # describe 'geoip'
