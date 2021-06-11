require 'spec_helper'

describe 'geoip' do
  describe 'geoip::install' do
    on_supported_os.each do |os, default_facts|
      context "on #{os}" do
        let(:facts) do
          default_facts
        end

        let(:params) do
          default_config(os)
        end

        case os
        when 'debian-10-x86_64'
          it { is_expected.to contain_package('mmdb-bin').with_ensure('latest') }
        when %r{(redhat|centos)-7-x86_64}
          it { is_expected.to contain_package('libmaxminddb-devel').with_ensure('latest') }
        when %r{(redhat|centos)-8-x86_64}
          it { is_expected.to contain_package('libmaxminddb').with_ensure('latest') }
        end
        it { is_expected.to contain_package('geoipupdate').with_ensure('latest') }
      end
    end
  end
end
