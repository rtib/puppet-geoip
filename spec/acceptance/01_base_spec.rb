require 'spec_acceptance_helper'

describe 'geoip' do
  context 'default installation' do
    let(:manifest) do
      <<-EOS
      class { 'geoip':
        update_timers => ['*:25'],
      }
      EOS
    end

    it_behaves_like 'an idempotent resource'
  end
end
