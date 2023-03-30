require 'spec_helper'

describe 'sensu', :type => :class do
  # Only test 1 OS to speed up tests when behavior does not vary based on OS facts
  on_supported_os({
    supported_os: [{ 'operatingsystem' => 'RedHat', 'operatingsystemrelease' => ['7'] }]
  }).each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      context 'with default values for all parameters' do
        it { should compile.with_all_deps }

        it { should contain_class('sensu')}
        it { should contain_class('sensu::resources') }
      end

      context 'with use_ssl => false' do
        let(:params) { { use_ssl: false } }
        context 'when puppet_localcacert undefined' do
          let(:facts) { facts.merge!(puppet_localcacert: nil) }
          it { should compile.with_all_deps }
        end
      end

      context 'when puppet_localcacert undefined' do
        let(:facts) { facts.merge!(puppet_localcacert: nil) }
        it { should compile.and_raise_error(/ssl_ca_source or ssl_ca_content must be defined/) }
      end
    end
  end
end

