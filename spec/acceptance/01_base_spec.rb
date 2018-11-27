require 'spec_acceptance_helper'

describe 'geoip' do
  context 'default installation' do
    let(:manifest) do
      <<-EOS
      include geoip
      EOS
    end

    it_behaves_like 'an idempotent resource'
  end
end
