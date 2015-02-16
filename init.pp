$user = 'fpizzurro'
$virtualbox_version = '4.3.22-98236'
$vagrant_version    = '1.7.2'

case $::operatingsystem {
  'windows': {
    $init_dir         = "C:\\vagrant-init"
    $tmp_dir          = "${init_dir}\\tmp"
    $librarian_command= 'librarian-puppet.bat install --clean'
    $librarian_path   = "C:\\Program Files\\Puppet Labs\\Puppet\\bin;C:\\Program Files\\Puppet Labs\\Puppet\\sys\\ruby\\bin;${::path}"
    $git_clone_user   = undef
    $home             = ''

    include windows_path
  }

  'ubuntu': {
    $tmp_dir          = '/tmp/vagrant-init'
    $librarian_command= 'librarian-puppet install --clean'
    $librarian_path   = $::path
    $git_clone_user   = $user
    $home             = "/home/$user"

    vagrant::plugin{'vagrant-librarian-puppet': home => $home}

    Class['vagrant'] ->
    Vagrant::Plugin['vagrant-librarian-puppet']
  }
}


class {'virtualbox': tmp_dir  => $tmp_dir, version => $virtualbox_version }
class {'vagrant': tmp_dir => $tmp_dir, version => $vagrant_version }
class {'git': tmp_dir => $tmp_dir}

include librarian_puppet

Class['virtualbox'] ->
Class['vagrant'] ->
Class['git'] ->
Class['librarian_puppet'] ->
