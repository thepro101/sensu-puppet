require 'spec_helper'

describe 'sensu::agent::config_entry' do
  # Only test 1 OS to speed up tests when behavior does not vary based on OS facts
  on_supported_os({
    supported_os: [{ 'operatingsystem' => 'RedHat', 'operatingsystemrelease' => ['7'] }]
  }).each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      let(:node) { 'localhost' }
      let(:title) { 'keepalive-interval' }
      let(:params) { { :value => 20 } }

      it {
        is_expected.to contain_datacat_fragment('sensu_agent_config-entry-keepalive-interval').with({
          'target' => 'sensu_agent_config',
          'data'   => {
            'keepalive-interval' => 20,
          },
          'order'  => '50',
        })
      }

      context 'all params' do
        let(:params) do
          {
            :value  => '90',
            :key    => 'foo',
            :order  => '01',
          }
        end
        it {
          is_expected.to contain_datacat_fragment('sensu_agent_config-entry-keepalive-interval').with({
            'target' => 'sensu_agent_config',
            'data'   => {
              'foo' => '90',
            },
            'order'  => '01',
          })
        }
      end
    end
  end
end
