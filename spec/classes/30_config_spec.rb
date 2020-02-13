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
        end
      end
    end # on_supported_os.each
  end
end # describe 'geoip'
