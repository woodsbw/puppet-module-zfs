# A class to manage ZFS on ubuntu hosts
class zfsmodule (
  $fuse = false,
){
  case $::operatingsystem {
    ubuntu : {
      if $fuse { 
        package { 'zfs-fuse':
          ensure => present,
        }
      } else {
        # install the ppa repos
        class {'repo':}->
        package {'ubuntu-zfs':
          ensure => latest,
        }
        #ubuntu 13.10 does not have this package!
        case $::lsbdistrelease {
          10.04,12.04,12.10,13.04 : {
            package {'zfs-auto-snapshot':
              ensure  => latest,
              require => Package['ubuntu-zfs'],
            }
          }
        }
      }
    }
    default : {
      fail("zfs is not currently supported on ${::operatingsystem}")
    }
  }
}