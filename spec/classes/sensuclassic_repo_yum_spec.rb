require 'spec_helper'

describe 'sensuclassic' do
  let(:facts) do
    {
      :osfamily        => 'RedHat',
      :operatingsystem => 'RedHat',
      :kernel          => 'Linux',
    }
  end
  let(:params) do
    { 'install_repo' => true, }
  end

  context 'on RedHat derivatives' do
    it { should create_class('sensuclassic::repo::yum') }
    it { should contain_yumrepo('sensuclassic').with(
      :enabled  => '1',
      :baseurl  => 'https://sensu.global.ssl.fastly.net/yum/$releasever/$basearch/',
      :gpgcheck => '0',
      :name     => 'sensuclassic',
      :descr    => 'sensu',
      :before   => 'Package[sensu]',
    ) }
  end

  context 'on RedHat 8' do
    let(:facts) do
      {
        :os              => {
          :release  => { :major => '8' },
          :family        => 'RedHat',
        },
        :operatingsystem => 'CentOS',
        :kernel          => 'Linux',
      }
    end
    it { should create_class('sensuclassic::repo::yum') }
    it { should contain_yumrepo('sensuclassic').with(
      :enabled  => '1',
      :baseurl  => 'https://sensu.global.ssl.fastly.net/yum/7/$basearch/',
      :gpgcheck => '0',
      :name     => 'sensuclassic',
      :descr    => 'sensu',
      :before   => 'Package[sensu]',
    ) }
  end

  context 'on Amazon Linux 2018.x' do
    let(:facts) do
      {
        :os              => {
          :release  => { :major => '2018' },
        },
        :operatingsystem => 'Amazon',
        :kernel          => 'Linux',
      }
    end

    it { should create_class('sensuclassic::repo::yum') }
    it { should contain_yumrepo('sensuclassic').with(
      :enabled  => '1',
      :baseurl  => 'https://sensu.global.ssl.fastly.net/yum/6/$basearch/',
      :gpgcheck => '0',
      :name     => 'sensuclassic',
      :descr    => 'sensu',
      :before   => 'Package[sensu]',
    ) }
  end

  context 'on Amazon Linux 2' do
    let(:facts) do
      {
        :os              => {
          :release  => { :major => '2' },
        },
        :operatingsystem => 'Amazon',
        :kernel          => 'Linux',
      }
    end

    it { should create_class('sensuclassic::repo::yum') }
    it { should contain_yumrepo('sensuclassic').with(
      :enabled  => '1',
      :baseurl  => 'https://sensu.global.ssl.fastly.net/yum/7/$basearch/',
      :gpgcheck => '0',
      :name     => 'sensuclassic',
      :descr    => 'sensu',
      :before   => 'Package[sensu]',
    ) }
  end
end
