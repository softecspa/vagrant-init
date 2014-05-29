$user = '--USERNAME--'

case $::operatingsystem {
  'windows': {
    $init_dir         = "C:\\vagrant-init"
    $tmp_dir          = "${init_dir}\\tmp"
    $vagrant_lamp_dir = 'C:\\vagrant-lamp'
    $librarian_command= 'librarian-puppet.bat install --clean'
    $librarian_path   = "C:\\Program Files\\Puppet Labs\\Puppet\\bin;C:\\Program Files\\Puppet Labs\\Puppet\\sys\\ruby\\bin;${::path}"
    $git_clone_user   = undef
    $env_librarian    = undef

    include windows_path
    package{'GnuWin32: Wget-1.11.4-1':
      ensure          => 'installed',
      source          => "${tmp_dir}\\wget-1.11.4-1-setup.exe",
      install_options => ['/SILENT']
    }
    class {'cygwin': tmp_dir => $tmp_dir}

    Package['GnuWin32: Wget-1.11.4-1'] ->
    Class['cygwin'] ->
    Class['virtualbox']
  }

  'ubuntu': {
    $tmp_dir          = '/tmp/vagrant-init'
    $vagrant_lamp_dir = "/home/${user}/vagrant-lamp"
    $librarian_command= 'librarian-puppet install --clean'
    $librarian_path   = $::path
    $git_clone_user   = $user
    $env_librarian    = ["HOME=/home/$user/"]
  }
}


class {'virtualbox': tmp_dir  => $tmp_dir}
class {'vagrant': tmp_dir => $tmp_dir}
include librarian_puppet
class {'git': tmp_dir => $tmp_dir}


git::clone {'vagrant-lamp':
  url   => 'github.com/softecspa/vagrant-lamp',
  path  => $vagrant_lamp_dir,
  user  => $git_clone_user
}

exec {'librarian-puppet-install':
  command     => $librarian_command,
  cwd         => $vagrant_lamp_dir,
  path        => $librarian_path,
  user        => $git_clone_user,
  environment => $env_librarian
}

Class['virtualbox'] ->
Class['vagrant'] ->
Class['librarian_puppet'] ->
Class['git'] ->
Git::Clone['vagrant-lamp'] ->
Exec['librarian-puppet-install']
