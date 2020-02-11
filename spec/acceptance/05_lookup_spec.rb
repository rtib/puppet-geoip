require 'spec_helper_acceptance'

describe 'lookup some addresses' do
  DBS.each do |db|
    context "against database #{db}" do
      describe 'valid IP address' do
        subject(:valid_country_lookup) { run_shell("mmdblookup --file /var/lib/GeoIP/#{db}.mmdb --ip 8.8.8.8 > lookup_valid_ip") }

        its(:exit_code) { is_expected.to eq 0 }
      end
      describe 'unknown IP address' do
        subject(:valid_country_lookup) { run_shell("mmdblookup --file /var/lib/GeoIP/#{db}.mmdb --ip 127.0.0.1 > lookup_localhost") }

        its(:exit_code) { is_expected.to eq 6 }
      end
      describe 'invalid IP address' do
        subject(:valid_country_lookup) { run_shell("mmdblookup --file /var/lib/GeoIP/#{db}.mmdb --ip 256.0.0.1 > lookup_invalid_ip") }

        its(:exit_code) { is_expected.to eq 3 }
      end
    end
  end
end
