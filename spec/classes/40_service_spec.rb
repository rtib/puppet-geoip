require 'spec_helper'

describe 'geoip' do
  describe 'geoip::service' do
    on_supported_os.each do |os, default_facts|
      context "on #{os}" do
        let(:facts) do
          default_facts
        end

        describe 'with systemd' do
          let(:params) do
            default_config(os)
          end

          it { is_expected.to contain_class('geoip::service::systemd') }
        end

        describe 'with init' do
          let(:facts) do
            default_facts.merge(
              'service_provider' => 'init',
            )
          end

          it { is_expected.to raise_error(Puppet::Error) }
        end
      end
    end # on_supported_os.each
  end
end # describe 'geoip'
