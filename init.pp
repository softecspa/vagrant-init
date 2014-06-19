$user = '--USERNAME--'
$virtualbox_version = '4.3.12-93733'
$vagrant_version    = '1.6.3'

case $::operatingsystem {
  'windows': {
    $init_dir         = "C:\\vagrant-init"
    $tmp_dir          = "${init_dir}\\tmp"
    $vagrant_lamp_dir = 'C:\\vagrant-lamp'
    $librarian_command= 'librarian-puppet.bat install --clean'
    $librarian_path   = "C:\\Program Files\\Puppet Labs\\Puppet\\bin;C:\\Program Files\\Puppet Labs\\Puppet\\sys\\ruby\\bin;${::path}"
    $git_clone_user   = undef
    $home             = ''
    $lamp_modules     = "$vagrant_lamp_dir\\modules"

    include windows_path
  }

  'ubuntu': {
    $tmp_dir          = '/tmp/vagrant-init'
    $vagrant_lamp_dir = "/home/${user}/vagrant-lamp"
    $librarian_command= 'librarian-puppet install --clean'
    $librarian_path   = $::path
    $git_clone_user   = $user
    $home             = "/home/$user"
    $lamp_modules     = "$vagrant_lamp_dir/modules"
  }
}


class {'virtualbox': tmp_dir  => $tmp_dir, version => $virtualbox_version }
class {'vagrant': tmp_dir => $tmp_dir, version => $vagrant_version }
vagrant::plugin{'vagrant-librarian-puppet': home => $home}
class {'git': tmp_dir => $tmp_dir}



git::clone {'vagrant-lamp':
  url   => 'github.com/softecspa/vagrant-lamp',
  path  => $vagrant_lamp_dir,
  user  => $git_clone_user
}

file {$lamp_modules:
  ensure  => directory
}

Class['virtualbox'] ->
Class['vagrant'] ->
Vagrant::Plugin['vagrant-librarian-puppet'] ->
Class['git'] ->
Git::Clone['vagrant-lamp'] ->
File[$lamp_modules]
