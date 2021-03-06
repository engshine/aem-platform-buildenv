class { 'nodejs':
  repo_url_suffix       => '8.x',
  nodejs_package_ensure => '8.10.0',
} -> package { ['open-sesame']:
  ensure   => 'present',
  provider => 'npm',
}

package { ['git', 'ShellCheck', 'unzip', 'wget', 'docker', 'jq', 'python-devel']:
  ensure   => 'present',
  provider => 'yum',
}

include pip
pip::install { 'ansible':
  ensure         => present,
  version        => '2.5.8',
  python_version => '2.7',
}
pip::install { 'awscli':
  ensure         => present,
  version        => '1.16.10',
  python_version => '2.7',
}

class { 'hashicorp::packer':
  version => '1.2.4',
}

archive { '/usr/local/bin/packer-post-processor-json-updater':
  source => 'https://github.com/cliffano/packer-post-processor-json-updater/releases/download/v1.2/packer-post-processor-json-updater_linux_amd64',
} -> file { '/usr/local/bin/packer-post-processor-json-updater':
  ensure => 'file',
  mode   => '0755',
}

class { '::phantomjs':
  package_version => '1.9.7',
  package_update  => true,
  install_dir     => '/usr/local/bin',
  source_dir      => '/opt',
  timeout         => 600,
}

class { 'java':
  distribution => 'jdk',
}

class { 'maven::maven':
  version => '3.5.0',
}
