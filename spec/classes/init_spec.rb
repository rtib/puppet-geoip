require 'spec_helper'
describe 'geoip' do
  context 'with default values for all parameters' do
    it { should contain_class('geoip') }
  end
end
