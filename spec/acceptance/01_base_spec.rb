require 'spec_helper_acceptance'

describe 'geoip' do
  context 'default installation' do
    let(:manifest) do
      <<-EOS
      class { 'geoip':
        config        => {
          userid     => '#{ENV['MM_LT311_USERID']}',
          licensekey => '#{ENV['MM_LT311_LICENSEKEY']}',
        },
        update_timers => ['*:25'],
      }
      EOS
    end

    it 'applies idempotently' do
      idempotent_apply(manifest)
    end
  end
end
