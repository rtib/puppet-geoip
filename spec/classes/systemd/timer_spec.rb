# frozen_string_literal: true

require 'spec_helper'
describe 'geoip' do
  describe 'geoip::systemd::timer' do
    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) { os_facts }

        let(:params) do
          default_config(os)
        end

        it { is_expected.to compile }
        describe 'add one timer' do
          let(:params) do
            default_config(os).merge({
                                       update_timers: ['Mon..Fri *-*-* 06:30:00'],
                systemd_config: 'unit',
                service_name: 'geoip_update'
                                     })
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
            default_config(os).merge({
                                       update_timers: ['Mon..Fri *-*-* 06:30:00', 'Mon..Fri *-*-* 18:30:00'],
              update_scatter: 300,
              systemd_config: 'unit',
              service_name: 'geoip_update'
                                     })
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
  end
end
