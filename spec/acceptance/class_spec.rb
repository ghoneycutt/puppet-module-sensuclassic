require 'spec_helper_acceptance'

describe 'sensuclassic class' do

  context 'sensuclassic' do
    context 'default' do
      pp = <<-EOS
      class { 'sensuclassic':}
      EOS

      if ! Gem.win_platform?
        it 'should work with no errors' do
          # Run it twice and test for idempotency
          apply_manifest(pp, :catch_failures => true)
          apply_manifest(pp, :catch_changes  => true)
        end
      else
        File.open('C:\manifest-client.pp', 'w') { |f| f.write(pp) }
        puts "C:\manifest-client.pp"
        puts File.read('C:\manifest-client.pp')
        describe command('puppet apply --debug C:\manifest-client.pp') do
          its(:exit_status) { is_expected.to eq 0 }
        end
      end

      describe service('sensu-client') do
        it { is_expected.to be_running }
        it { is_expected.to be_enabled }
      end

    end #default

    context 'server => true, api => true' do
      if fact('osfamily') == 'windows'
        before { skip("Server not supported on Windows") }
      end
      it 'should work with no errors' do
        pp = <<-EOS
        class { 'sensuclassic':
          server                   => true,
          api                      => true,
          purge                    => true,
          rabbitmq_password        => 'secret',
          rabbitmq_host            => '127.0.0.1',
        }
        sensuclassic::handler { 'default':
          command => "mail -s 'sensu alert' ops@example.com",
        }
        sensuclassic::check { 'check_ntp':
          command     => 'PATH=$PATH:/usr/lib64/nagios/plugins check_ntp_time -H pool.ntp.org -w 30 -c 60',
          handlers    => 'default',
          subscribers => 'sensu-test',
        }
        EOS

        # Run it twice and test for idempotency
        apply_manifest(pp, :catch_failures => true)
        apply_manifest(pp, :catch_changes  => true)
      end

      describe service('sensu-server') do
        it { is_expected.to be_running }
        it { is_expected.to be_enabled }
      end

      describe service('sensu-client') do
        it { is_expected.to be_running }
        it { is_expected.to be_enabled }
      end

      describe service('sensu-api') do
        it { is_expected.to be_running }
        it { is_expected.to be_enabled }
      end
    end # server and api

    if ENV['SE_USER'] && ENV['SE_PASS']
      context 'enterprise => true and enterprise_dashboard => true' do
        if fact('osfamily') == 'windows'
          before { skip("Enterprise not supported on Windows") }
        end
        it 'should work with no errors' do
          pp = <<-EOS
          class { 'sensuclassic':
            enterprise           => true,
            enterprise_dashboard => true,
            enterprise_user      => '#{ENV['SE_USER']}',
            enterprise_pass      => '#{ENV['SE_PASS']}',
            rabbitmq_password    => 'secret',
            rabbitmq_host        => '127.0.0.1',
          }
          sensuclassic::enterprise::dashboard::api { 'sensu.example.com':
            datacenter => 'example-dc',
          }
          EOS

          # Run it twice and test for idempotency
          apply_manifest(pp, :catch_failures => true)
          apply_manifest(pp, :catch_failures => true)
        end

        describe file('/etc/sensu/dashboard.json') do
          it { is_expected.to be_file }
          its(:content) { should match /name.*?example-dc/ }
          its(:content) { should match /host.*?sensu\.example\.com/ }
        end

        describe service('sensu-server') do
          it { is_expected.to_not be_running }
          it { is_expected.to_not be_enabled }
        end

        describe service('sensu-client') do
          it { is_expected.to be_running }
          it { is_expected.to be_enabled }
        end

        describe service('sensu-enterprise') do
          it { is_expected.to be_running }
          it { is_expected.to be_enabled }
        end

        describe service('sensu-enterprise-dashboard') do
          it { is_expected.to be_running }
          it { is_expected.to be_enabled }
        end

        describe service('sensu-api') do
          it { is_expected.to_not be_running }
          it { is_expected.to_not be_enabled }
        end
      end # enterprise and enterprise_dashboard
    end

    context 'client => false' do
      pp = <<-EOS
      class { 'sensuclassic':
        client => false
      }
      EOS

      if ! Gem.win_platform?
        it 'should work with no errors' do
          # Run it twice and test for idempotency
          apply_manifest(pp, :catch_failures => true)
          apply_manifest(pp, :catch_changes  => true)
        end
      else
        File.open('C:\manifest-client-false.pp', 'w') { |f| f.write(pp) }
        puts "C:\manifest-client-false.pp"
        puts File.read('C:\manifest-client-false.pp')
        describe command('puppet apply C:\manifest-client-false.pp') do
          its(:exit_status) { is_expected.to eq 0 }
        end
      end

      describe service('sensu-client') do
        it { is_expected.not_to be_running }
        it { is_expected.not_to be_enabled }
      end
    end # no client
  end # sensu
end
