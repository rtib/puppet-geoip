require 'spec_helper_acceptance'

describe 'geoip' do
  context 'default installation' do
    let(:manifest_both_lt311) do
      <<-EOS
      class { 'geoip':
        config        => {
          accountid  => '#{ENV['MM_USERID']}',
          userid     => '#{ENV['MM_USERID']}',
          licensekey => '#{ENV['MM_LICENSEKEY_LT311']}',
        },
        update_timers => ['*:25'],
      }
      EOS
    end
    let(:manifest_both_ge311) do
      <<-EOS
      class { 'geoip':
        config        => {
          accountid  => '#{ENV['MM_USERID']}',
          userid     => '#{ENV['MM_USERID']}',
          licensekey => '#{ENV['MM_LICENSEKEY_GE311']}',
        },
        update_timers => ['*:25'],
      }
      EOS
    end
    let(:manifest_lt311) do
      <<-EOS
      class { 'geoip':
        config        => {
          userid     => '#{ENV['MM_USERID']}',
          licensekey => '#{ENV['MM_LICENSEKEY_LT311']}',
        },
        update_timers => ['*:25'],
      }
      EOS
    end
    let(:manifest_ge311) do
      <<-EOS
      class { 'geoip':
        config        => {
          accountid  => '#{ENV['MM_USERID']}',
          licensekey => '#{ENV['MM_LICENSEKEY_GE311']}',
        },
        update_timers => ['*:25'],
      }
      EOS
    end

    it 'applies idempotently < 3.1.1 config', unless: CONFIG_GE311 do
      idempotent_apply(manifest_lt311)
    end
    it 'applies idempotently >= 3.1.1 transitional config', if: CONFIG_GE311 do
      idempotent_apply(manifest_both_lt311)
    end
    it 'applies idempotently >= 3.1.1 config', if: CONFIG_GE311 do
      idempotent_apply(manifest_ge311)
    end
  end
end
