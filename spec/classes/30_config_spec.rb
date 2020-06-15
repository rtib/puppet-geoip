require 'spec_helper'

describe 'geoip' do
  describe 'geoip::config' do
    on_supported_os.each do |os, default_facts|
      context "on #{os}" do
        let(:facts) do
          default_facts
        end

        describe "geoipupdate #{config_for(os)[:name]}" do
          let(:params) do
            default_config(os)
          end

          it { is_expected.to contain_class("geoip::config::#{config_for(os)[:class]}") }
          it { is_expected.to contain_class('geoip::systemd::service') }
        end
      end
    end # on_supported_os.each

    context 'on unsupported os' do
      let(:facts) do
        {
          service_provider: 'foobar',
        }
      end
      let(:params) do
        default_config('unsupported-os')
      end

      it 'raise a warning' do
        expect { catalogue }.to raise_error(Puppet::PreformattedError, %r{unknown service provider \(foobar\).})
      end
    end
  end
end # describe 'geoip'
