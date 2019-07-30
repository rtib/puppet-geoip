require 'spec_helper_acceptance'

describe 'lookup some addresses' do
  DBS = ['GeoLite2-Country', 'GeoLite2-City'].freeze

  DBS.each do |db|
    context "against database #{db}" do
      describe 'valid IP address' do
        subject(:valid_country_lookup) { command("mmdblookup --file /var/lib/GeoIP/#{db}.mmdb --ip 8.8.8.8") }

        its(:exit_status) { is_expected.to eq 0 }
      end
      describe 'unknown IP address' do
        subject(:valid_country_lookup) { command("mmdblookup --file /var/lib/GeoIP/#{db}.mmdb --ip 127.0.0.1") }

        its(:exit_status) { is_expected.to eq 6 }
      end
      describe 'invalid IP address' do
        subject(:valid_country_lookup) { command("mmdblookup --file /var/lib/GeoIP/#{db}.mmdb --ip 256.0.0.1") }

        its(:exit_status) { is_expected.to eq 3 }
      end
    end
  end
end
