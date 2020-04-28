# frozen_string_literal: true

require 'spec_helper'

describe 'geoip' do
  describe 'geoip::systemd::service' do
    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) { os_facts }

        let(:params) do
          default_config(os)
        end

        it { is_expected.to compile }
        context 'systemd unit file contents' do
          it do
            is_expected.to contain_systemd__unit_file('geoip_update.service')
              .with('ensure' => 'present')
          end
          it do
            is_expected.to contain_systemd__unit_file('geoip_update.service')
              .with_content(%r{^Type=exec$})
          end
          it do
            is_expected.to contain_systemd__unit_file('geoip_update.service')
              .with_content(%r{^ExecStart=/usr/bin/geoipupdate -v -f /etc/GeoIP.conf$})
          end
          it do
            is_expected.to contain_systemd__unit_file('geoip_update.service')
              .with_content(%r{^Restart=on-failure$})
          end
          it do
            is_expected.to contain_systemd__unit_file('geoip_update.service')
              .with_content(%r{^RestartSec=5min$})
          end
          it do
            is_expected.to contain_systemd__unit_file('geoip_update.service')
              .with_content(%r{^StandardOutput=journal$})
          end
          it do
            is_expected.to contain_systemd__unit_file('geoip_update.service')
              .with_content(%r{^StandardError=journal$})
          end
        end
      end
    end
  end
end
