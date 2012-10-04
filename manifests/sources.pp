# source.pp
# add an apt source

define apt::sources(
  $host = false,
) {

  if ! $host {
    $apt_host = $name
  } else {
    $apt_host = $host
  }

  include apt::params

  file { "sources.list":
    path => "${apt::params::root}/sources.list",
    ensure => present,
    owner => root,
    group => root,
    mode => 644,
    content => template("apt/sources.list.erb"),
    notify => Exec["apt_update"],
  }

}
