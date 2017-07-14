require 'spec_helper'
describe 'geoip' do
  on_supported_os.each do |os,default_facts|
    context "on #{os}" do
      let(:facts) do
        default_facts.merge({
          :service_provider => 'systemd'
        })
      end
      context 'with default values' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('geoip') }
        it { is_expected.to contain_class('geoip::install').that_comes_before('Class[geoip::config]') }
        it { is_expected.to contain_class('geoip::config') }
        it { is_expected.to contain_class('geoip::service').that_subscribes_to('Class[geoip::config]') }
      end # context 'with default values'
    end # context "on #{os}"
  end # on_supported_os.each
end # describe 'geoip'
