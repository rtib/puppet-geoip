# frozen_string_literal: true

require 'spec_helper'

describe 'geoip' do
  describe 'geoip::systemd::service' do
    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) { os_facts }

        context 'default config' do
          let(:params) do
            default_config(os)
          end

          it { is_expected.to compile }
          context 'systemd unit file contents' do
            it do
              is_expected.to contain_systemd__unit_file('geoip_update.service')
                .with('ensure' => 'present')
            end
            if os_facts['systemd_version'] >= 240
              it do
                is_expected.to contain_systemd__unit_file('geoip_update.service')
                  .with_content(%r{^Type=exec$})
              end
            else
              it do
                is_expected.to contain_systemd__unit_file('geoip_update.service')
                  .with_content(%r{^Type=oneshot$})
              end
            end
            it do
              is_expected.to contain_systemd__unit_file('geoip_update.service')
                .with_content(%r{^User=root$})
            end
            it do
              is_expected.to contain_systemd__unit_file('geoip_update.service')
                .with_content(%r{^Group=root$})
            end
            it do
              is_expected.to contain_systemd__unit_file('geoip_update.service')
                .with_content(%r{^ExecStart=/usr/bin/geoipupdate -v -f /etc/GeoIP.conf$})
            end
            if os_facts['systemd_version'] >= 240
              it do
                is_expected.to contain_systemd__unit_file('geoip_update.service')
                  .with_content(%r{^Restart=on-failure$})
              end
              it do
                is_expected.to contain_systemd__unit_file('geoip_update.service')
                  .with_content(%r{^RestartSec=5min$})
              end
            else
              it do
                is_expected.not_to contain_systemd__unit_file('geoip_update.service')
                  .with_content(%r{^Restart=on-failure$})
              end
              it do
                is_expected.not_to contain_systemd__unit_file('geoip_update.service')
                  .with_content(%r{^RestartSec=5min$})
              end
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

        context 'alternate user/group config' do
          let(:params) do
            default_config(os).merge(
              'service_user'  => 'geo_user',
              'service_group' => 'geo_group',
            )
          end

          it { is_expected.to compile }
          context 'systemd unit file contents' do
            it do
              is_expected.to contain_systemd__unit_file('geoip_update.service')
                .with('ensure' => 'present')
            end
            it do
              is_expected.to contain_systemd__unit_file('geoip_update.service')
                .with_content(%r{^User=geo_user$})
            end
            it do
              is_expected.to contain_systemd__unit_file('geoip_update.service')
                .with_content(%r{^Group=geo_group$})
            end
          end
        end
      end
    end
  end
end
