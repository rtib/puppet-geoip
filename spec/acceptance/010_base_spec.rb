require 'spec_helper_acceptance'

describe 'geoip' do
  context 'default installation' do
    let(:manifest_lt311) do
      <<-EOS
      file { '/usr/local/share/GeoIP':
        ensure => directory,
      }
      class { 'geoip':
        config        => {
          database_directory => '/usr/local/share/GeoIP',
          userid             => '#{ENV['MM_USERID']}',
          licensekey         => '#{ENV['MM_LICENSEKEY_LT311']}',
        },
        update_timers => ['*:25'],
      }
      EOS
    end
    let(:manifest_ge311) do
      <<-EOS
      file { '/usr/local/share/GeoIP':
        ensure => directory,
      }
      class { 'geoip':
        config        => {
          database_directory => '/usr/local/share/GeoIP',
          accountid  => '#{ENV['MM_USERID']}',
          licensekey => '#{ENV['MM_LICENSEKEY_GE311']}',
        },
        update_timers => ['*:25'],
      }
      EOS
    end

    it 'applies idempotently < 3.1.1 config', unless: config_ge311? do
      idempotent_apply(manifest_lt311)
    end
    it 'applies idempotently >= 3.1.1 config', if: config_ge311? do
      idempotent_apply(manifest_ge311)
    end
  end
end
