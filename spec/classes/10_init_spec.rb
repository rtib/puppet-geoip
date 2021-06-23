require 'spec_helper'

describe 'geoip' do
  on_supported_os.each do |os, default_facts|
    context "on #{os}" do
      let(:facts) do
        default_facts
      end

      let(:params) do
        default_config(os)
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('geoip') }
      it { is_expected.to contain_class('geoip::install').that_comes_before('Class[geoip::config]') }
      it { is_expected.to contain_class('geoip::config') }
      it { is_expected.to contain_class('geoip::service').that_subscribes_to('Class[geoip::config]') }
    end
  end # on_supported_os.each
end # describe 'geoip'
