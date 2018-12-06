require 'spec_helper'
describe 'geoip' do
  on_supported_os.each do |os, default_facts|
    context "on #{os}" do
      let(:facts) do
        default_facts
      end

      context 'module structure' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('geoip') }
        it { is_expected.to contain_class('geoip::install').that_comes_before('Class[geoip::config]') }
        it { is_expected.to contain_class('geoip::config') }
        it { is_expected.to contain_class('geoip::service').that_subscribes_to('Class[geoip::config]') }
      end # context 'with default values'

      context 'config file contents' do
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
            .with_content(%r{^UserId 999999$})
        end
        it do
          is_expected.to contain_file('/etc/GeoIP.conf')
            .with_content(%r{^LicenseKey 000000000000$})
        end
        it do
          is_expected.to contain_file('/etc/GeoIP.conf')
            .with_content(%r{^ProductIds GeoLite2-City GeoLite2-Country$})
        end
      end # context 'config file contents'

      context 'systemd unit file contents' do
        it do
          is_expected.to contain_systemd__unit_file('geoip_update.service')
            .with('ensure' => 'present')
        end
        it do
          is_expected.to contain_systemd__unit_file('geoip_update.service')
            .with_content(%r{^Type=oneshot$})
        end
        it do
          is_expected.to contain_systemd__unit_file('geoip_update.service')
            .with_content(%r{^ExecStart=/usr/bin/geoipupdate -v /etc/GeoIP.conf$})
        end
      end # context 'systemd unit file contents'
    end # context "on #{os}"
  end # on_supported_os.each
end # describe 'geoip'
