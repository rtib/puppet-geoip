require 'spec_helper_acceptance'

describe 'lookup some addresses' do
  DBS.each do |db|
    context "against database #{db}" do
      describe 'valid IP address' do
        subject { run_shell("mmdblookup --file /usr/local/share/GeoIP/#{db}.mmdb --ip 8.8.8.8 > /dev/null") }

        its(:exit_code) { is_expected.to eq 0 }
      end
      describe 'unknown IP address' do
        subject do
          run_shell(
            "mmdblookup --file /usr/local/share/GeoIP/#{db}.mmdb --ip 127.0.0.1",
            expect_failures: true,
          )
        end

        its(:exit_code) { is_expected.to eq 6 }
        its(:stderr) { is_expected.to match 'Could not find an entry for this IP address \(127.0.0.1\)' }
      end
      describe 'invalid IP address' do
        subject do
          run_shell(
            "mmdblookup --file /usr/local/share/GeoIP/#{db}.mmdb --ip 256.0.0.1",
            expect_failures: true,
          )
        end

        its(:exit_code) { is_expected.to eq 3 }
        its(:stderr) { is_expected.to match 'Error from call to getaddrinfo for 256.0.0.1 - Name or service not known' }
      end
    end
  end
end
