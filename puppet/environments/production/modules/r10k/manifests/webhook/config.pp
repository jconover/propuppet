# == Class: r10k::webhook::config
#
# Set up the root r10k config file (/etc/webhook.yaml).
#
# === Authors
#
# Zack Smith <zack@puppetlabs.com>
class r10k::webhook::config (
  $hash               = 'UNSET',
  $certname           = $r10k::params::webhook_certname,
  $certpath           = $r10k::params::webhook_certpath,
  $user               = $r10k::params::webhook_user,
  $pass               = $r10k::params::webhook_pass,
  $port               = $r10k::params::webhook_port,
  $logfile            = $r10k::params::webhook_logfile,
  $client_cfg         = $r10k::params::webhook_client_cfg,
  $use_mco_ruby       = $r10k::params::webhook_use_mco_ruby,
  $protected          = $r10k::params::webhook_protected,
  $discovery_timeout  = $r10k::params::webhook_discovery_timeout,
  $client_timeout     = $r10k::params::webhook_client_timeout,
  $prefix             = $r10k::params::webhook_prefix,
  $prefix_command     = $r10k::params::webhook_prefix_command,
  $enable_ssl         = $r10k::params::webhook_enable_ssl,
  $configfile         = '/etc/webhook.yaml',
) inherits r10k::params {

  if $hash == 'UNSET' {
    $webhook_hash  = {
      'user'              => $user,
      'pass'              => $pass,
      'port'              => $port,
      'certname'          => $certname,
      'client_timeout'    => $client_timeout,
      'discovery_timeout' => $discovery_timeout,
      'certpath'          => $certpath,
      'client_cfg'        => $client_cfg,
      'certpath'          => $certpath,
      'use_mco_ruby'      => $use_mco_ruby,
      'logfile'           => $logfile,
      'protected'         => $protected,
      'prefix'            => $prefix,
      'prefix_command'    => $prefix_command,
      'enable_ssl'        => $enable_ssl,
    }
  } else {
    validate_hash($hash)
    $webhook_hash = $hash
  }

  file { 'webhook.yaml':
    ensure  => file,
    owner   => 'root',
    group   => '0',
    mode    => '0644',
    path    => $configfile,
    content => template('r10k/webhook.yaml.erb'),
  }
}
