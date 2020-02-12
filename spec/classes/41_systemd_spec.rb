require 'spec_helper'

describe 'geoip' do
  describe 'geoip::service::systemd' do
    on_supported_os.each do |os, default_facts|
      context "on #{os}" do
        let(:facts) do
          default_facts
        end

        describe 'with systemd' do
          let(:params) do
            {
              'config' => {
                'userid'     => '999999',
                'licensekey' => '000000000000',
              },
            }
          end

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
          end
          describe 'add one timer' do
            let(:params) do
              {
                'config' => {
                  'userid'     => '999999',
                  'licensekey' => '000000000000',
                },
                'update_timers' => ['Mon..Fri *-*-* 06:30:00'],
              }
            end

            context 'systemd timer file contents' do
              it do
                is_expected.to contain_systemd__unit_file('geoip_update.timer')
                  .with('ensure' => 'present')
              end
              it do
                is_expected.to contain_systemd__unit_file('geoip_update.timer')
                  .with_content(%r{^OnCalendar=Mon\.\.Fri \*\-\*\-\* 06:30:00$})
              end
              it do
                is_expected.to contain_systemd__unit_file('geoip_update.timer')
                  .with_content(%r{^AccuracySec=1800$})
              end
            end # context 'systemd timer file contents'
          end # describe 'add one timer'

          describe 'add multiple timers' do
            let(:params) do
              {
                'config' => {
                  'userid'     => '999999',
                  'licensekey' => '000000000000',
                },
                'update_timers'  => ['Mon..Fri *-*-* 06:30:00', 'Mon..Fri *-*-* 18:30:00'],
                'update_scatter' => 300,
              }
            end

            context 'systemd timer file contents' do
              it do
                is_expected.to contain_systemd__unit_file('geoip_update.timer')
                  .with('ensure' => 'present')
              end
              it do
                is_expected.to contain_systemd__unit_file('geoip_update.timer')
                  .with_content(%r{^OnCalendar=Mon\.\.Fri \*\-\*\-\* 06:30:00$})
              end
              it do
                is_expected.to contain_systemd__unit_file('geoip_update.timer')
                  .with_content(%r{^OnCalendar=Mon\.\.Fri \*\-\*\-\* 18:30:00$})
              end
              it do
                is_expected.to contain_systemd__unit_file('geoip_update.timer')
                  .with_content(%r{^AccuracySec=300$})
              end
            end # context 'systemd timer file contents'
          end # describe 'add one timer'
        end
      end
    end # on_supported_os.each
  end
end # describe 'geoip'
