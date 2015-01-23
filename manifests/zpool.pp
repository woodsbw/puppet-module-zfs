class zfsmodule::zpool (
  $pool = hiera('zfsmodule::zpool::pool'),
  $ensure = hiera('zfsmodule::zpool::ensure', 'present'),
  $raid_parity = hiera('zfsmodule::zpool::raid_parity'),
  $raidz = hiera_array('zfsmodule::zpool::raidz'),
) {
    zpool { $pool:
      ensure => $ensure,
      raid_parity => $raid_parity,
      raidz => $raidz,
    }
}