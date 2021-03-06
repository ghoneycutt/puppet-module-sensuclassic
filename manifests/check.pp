# @summary Creates Sensu checks
#
# This define manages Sensu checks
#
# @param command The check command to run
#
# @param ensure Whether the check should be present or not.
#   Valid values: present, absent
#
# @param type Type of check. Set this to 'absent' to remove it completely.
#
# @param handlers Array of Strings. Handlers to use for this check.
#   Set this to 'absent' to remove it completely.
#
# @param contacts Array of Strings. Contacts to use for the contact-routing
#   Sensu Enterprise feature. This value corresponds with a sensuclassic::contact
#   resource having the same name.
#
# @param standalone When true, scheduled by the client. When false, listen for
#   published check request. Set this to 'absent' to remove it completely.
#
# @param cron When the check should be executed, using the [Cron
#   syntax](https://en.wikipedia.org/wiki/Cron#CRON_expression). Supersedes the
#   `interval` parameter. Example: `"0 0 * * *"`.
#
# @param interval How frequently (in seconds) the check will be executed.
#   Set this to 'absent' to remove it completely.
#
# @param occurrences The number of event occurrences before the handler should
#   take action. Set this to 'absent' to remove it completely.
#
# @param refresh The number of seconds sensu-plugin-aware handlers should wait
#   before taking second action. Set this to 'absent' to remove it completely.
#
# @param source The check source, used to create a JIT Sensu client for an
#   external resource (e.g. a network switch). Set this to 'absent' to remove
#   it completely.
#
# @param subscribers Array of Strings. Which subscriptions must execute this check.
#   Set this to 'absent' to remove it completely.
#
# @param low_flap_threshold Flap detection - see [Nagios Flap Detection](http://nagios.sourceforge.net/docs/3_0/flapping.html).
#   Set this to 'absent' to remove it completely.
#
# @param high_flap_threshold Flap detection - see [Nagios Flap Detection](http://nagios.sourceforge.net/docs/3_0/flapping.html).
#   Set this to 'absent' to remove it completely.
#
# @param timeout Check timeout in seconds, after it fails.
#   Set this to 'absent' to remove it completely.
#
# @param aggregate Aggregates, preventing event floods. Set 'aggregate:<name>' and
#   'handle:false', this prevents the server from sending to a handler, and makes
#   the aggregated results available under /aggregates in the REST API.
#   Set this to 'absent' to remove it completely.
#
# @param aggregates Array of Strings. An array of aggregates to add to the check.
#   This supercedes the above aggregate parameter.
#   Set this to 'absent' to remove it completely.
#
# @param handle When false, check will not be sent to handlers.
#   Set this to 'absent' to remove it completely.
#
# @param publish Unpublished checks. Prevents the check from being triggered on
#   clients. This allows for the definition of commands that are not actually
#   'checks' per say, but actually arbitrary commands for remediation.
#   Set this to 'absent' to remove it completely.
#   Default: undef
#
# @param dependencies List of checks this check depends on.
#   Note: The validity of the other checks is not enforced by puppet
#   Set this to 'absent' to remove it completely.
#
# @param content Mapping of arbitrary attributes from the top-level of the target
#   configuration JSON map. This parameter is intended to configure plugins and
#   extensions which look up values outside of the check configuration scope.
#   Example: { "mailer" => { "mail_from" => "sensu@example.com", "mail_to" => "monitor@example.com" } }
#
# @param custom List of custom attributes to include in the check.
#   You can use it to pass any attribute that is not listed here explicitly.
#   Example: { 'remediation' => { 'low_remediation' => { 'occurrences' => [1,2], 'severities' => [1], 'command' => "/bin/command", 'publish' => false, } } }
#
# @param ttl The time to live (TTL) in seconds until check results are
#   considered stale. Set this to 'absent' to remove it completely.
#
# @param ttl_status The exit code that a check with the ttl attribute should return.
#   Set this to 'absent' to remove it completely.
#
# @param auto_resolve When a check in a WARNING or CRITICAL state returns to an OK state, the event generated by the
#   WARNING or CRITICAL state will be automatically resolved. Set this to 'absent' to remove it completely.
#
# @param force_resolve
#   Setting force_resolve to true on a check result ensures that the event is resolved and removed from the registry, regardless of the current event action.
#
# @param subdue Check subdue configuration.
#   Set this to 'absent' to remove it completely.
#
# @param proxy_requests Manages [Proxy Check Requests](https://sensuapp.org/docs/latest/reference/checks.html#proxy-requests-attributes)
#   Since Sensu 0.28.0. Publishes a check request to every Sensu client which
#   matches the defined client attributes. See the documentation for the format
#   of the Hash value.
#
# @param hooks Manages
# [Hooks](https://sensuapp.org/docs/latest/reference/checks.html#hooks-attributes)
#   Since Sensu 1.1.0. Manages hooks for a check. See the documentation for the format
#   of the Hash value.
#
# @param output_format
#   [Docs](https://docs.sensu.io/sensu-enterprise/latest/built-in-mutators/#output-format)
#   A metric output format
#
# @param handle_when
#   [Docs](https://docs.sensu.io/sensu-enterprise/latest/filters/handle-when/)
#   The handle_when enterprise filter is used to reduce notification “noise”
#
# @param extension
#   The name of a Sensu check extension to run instead of a command.
#
# @param truncate_output
#   If check output will be truncated for storage.
#
# @param truncate_output_length
#   The output truncation length, the maximum number of characters.
#
define sensuclassic::check (
  Optional[String] $command = undef,
  Enum['present','absent'] $ensure = 'present',
  Optional[String] $type = undef,
  Variant[Undef,String,Array] $handlers = undef,
  Variant[Undef,String,Array] $contacts = undef,
  Variant[Boolean,Enum['absent']] $standalone = true,
  String $cron = 'absent',
  Variant[Integer,Enum['absent']] $interval = 60,
  Variant[Undef,Pattern[/^(\d+)$/],Integer,Enum['absent']] $occurrences = undef,
  Variant[Undef,Enum['absent'],Integer] $refresh = undef,
  Variant[Undef,String,Integer] $source = undef,
  Variant[Undef,String,Array] $subscribers = undef,
  Variant[Undef,Enum['absent'],Integer] $low_flap_threshold = undef,
  Variant[Undef,Enum['absent'],Integer] $high_flap_threshold = undef,
  Variant[Undef,Enum['absent'],Numeric] $timeout = undef,
  Optional[String] $aggregate = undef,
  Variant[Undef,String,Array] $aggregates = undef,
  Variant[Undef,Enum['absent'],Boolean] $handle = undef,
  Variant[Undef,Enum['absent'],Boolean] $publish = undef,
  Variant[Undef,String,Array] $dependencies = undef,
  Optional[Hash] $custom = undef,
  Hash $content = {},
  Variant[Undef,Enum['absent'],Integer] $ttl = undef,
  Variant[Undef,Enum['absent'],Integer,Pattern[/^(\d+)+$/]] $ttl_status = undef,
  Variant[Undef,Enum['absent'],Boolean] $auto_resolve = undef,
  Optional[Variant[Enum['absent'],Boolean]] $force_resolve = undef,
  Variant[Undef,Enum['absent'],Hash] $subdue = undef,
  Variant[Undef,Enum['absent'],Hash] $proxy_requests = undef,
  Variant[Undef,Enum['absent'],Hash] $hooks = undef,
  Optional[String[1]] $output_format = undef,
  Optional[Struct[{'occurrences' => Integer, 'reset' => Integer}]] $handle_when = undef,
  Optional[String] $extension = undef,
  Optional[Boolean] $truncate_output = undef,
  Optional[Integer] $truncate_output_length = undef,
) {

  include sensuclassic

  if $ensure == 'present' and !$command {
    fail("sensuclassic::check{${name}}: a command must be given when ensure is present")
  }

  if $subdue =~ Hash {
    if !( has_key($subdue, 'days') and $subdue['days'] =~ Hash ){
      fail("sensuclassic::check{${name}}: subdue hash should have a proper format. (got: ${subdue}) See https://sensuapp.org/docs/latest/reference/checks.html#subdue-attributes")
    }
  }
  if $proxy_requests {
    if $proxy_requests =~ Hash {
      if !( has_key($proxy_requests, 'client_attributes') ) {
        fail("sensuclassic::check{${name}}: proxy_requests hash should have a proper format. (got: ${proxy_requests})  See https://sensuapp.org/docs/latest/reference/checks.html#proxy-requests-attributes")
      }
    } elsif !($proxy_requests == 'absent') {
      fail("sensuclassic::check{${name}}: proxy_requests must be a hash or 'absent' (got: ${proxy_requests})")
    }
  }

  $check_name = regsubst(regsubst($name, ' ', '_', 'G'), '[\(\)]', '', 'G')

  # If cron is specified, interval should not be written to the configuration
  if $cron and $cron != 'absent' {
    $interval_real = 'absent'
  } else {
    $interval_real = $interval
  }

  case $handlers {
    Pattern[/absent/]: { $handlers_array = undef }
    String:   { $handlers_array = [ $handlers ] }
    default:  { $handlers_array = $handlers }
  }
  case $subscribers {
    Pattern[/absent/]: { $subscribers_array = undef }
    String:   { $subscribers_array = [ $subscribers ] }
    default:  { $subscribers_array = $subscribers }
  }
  case $aggregates {
    Pattern[/absent/]: { $aggregates_array = undef }
    String:   { $aggregates_array = [ $aggregates ] }
    default:  { $aggregates_array = $aggregates }
  }
  case $contacts {
    Pattern[/absent/]: { $contacts_array = undef }
    String:   { $contacts_array = [ $contacts ] }
    default:  { $contacts_array = $contacts }
  }
  case $dependencies {
    Pattern[/absent/]: { $dependencies_array = undef }
    String:   { $dependencies_array = [ $dependencies ] }
    default:  { $dependencies_array = $dependencies }
  }

  # (#463) All plugins must come before all checks. Collections are not used to
  # avoid realizing any resources.
  Anchor['plugins_before_checks']
  ~> Sensuclassic::Check[$name]

  if is_hash($hooks) {
    $hooks.each |$k,$v| {
      $valid_k = $k ? {
        Integer[1,255]                                           => true,
        Enum['ok', 'warning', 'critical', 'unknown', 'non-zero'] => true,
        default => fail("Illegal value for ${k} hook. Valid values are: Integers from 1 to 255 and any of 'ok', 'warning', 'critical', 'unknown', 'non-zero'"),
      }
    }
  }

  # This Hash map will ultimately exist at `{"checks" => {"$check_name" =>
  # $check_config}}`
  $check_config_start = {
    type                   => $type,
    standalone             => $standalone,
    command                => $command,
    handlers               => $handlers_array,
    contacts               => $contacts_array,
    cron                   => $cron,
    interval               => $interval_real,
    occurrences            => $occurrences,
    refresh                => $refresh,
    source                 => $source,
    subscribers            => $subscribers_array,
    low_flap_threshold     => $low_flap_threshold,
    high_flap_threshold    => $high_flap_threshold,
    timeout                => $timeout,
    aggregate              => $aggregate,
    aggregates             => $aggregates_array,
    handle                 => $handle,
    publish                => $publish,
    dependencies           => $dependencies_array,
    subdue                 => $subdue,
    proxy_requests         => $proxy_requests,
    hooks                  => $hooks,
    ttl                    => $ttl,
    ttl_status             => $ttl_status,
    auto_resolve           => $auto_resolve,
    force_resolve          => $force_resolve,
    output_format          => $output_format,
    handle_when            => $handle_when,
    extension              => $extension,
    truncate_output        => $truncate_output,
    truncate_output_length => $truncate_output_length,
  }

  # Remove key/value pares where the value is `undef` or `"absent"`.
  $check_config_pruned = $check_config_start.reduce({}) |$memo, $kv| {
    $kv[1] ? {
      undef    => $memo,
      'absent' => $memo,
      default  => $memo + Hash.new($kv),
    }
  }

  # Merge the specified properties on top of the custom hash.
  if $custom == undef {
    $check_config = $check_config_pruned
  } else {
    $check_config = $custom + $check_config_pruned
  }

  # Merge together the "checks" scope with any arbitrary config specified via
  # `content`.
  $checks_scope_start = { $check_name => $check_config }
  if $content['checks'] == undef {
    $checks_scope = { 'checks' => $checks_scope_start }
  } else {
    $checks_scope = { 'checks' => $content['checks'] + $checks_scope_start }
  }

  # The final structure from the top level. Check configuration scope is merged
  # on top of any arbitrary plugin and extension configuration in $content.
  $content_real = $content + $checks_scope

  sensuclassic::write_json { "${sensuclassic::conf_dir}/checks/${check_name}.json":
    ensure      => $ensure,
    content     => $content_real,
    owner       => $sensuclassic::user,
    group       => $sensuclassic::group,
    mode        => $sensuclassic::config_file_mode,
    notify_list => $sensuclassic::check_notify,
  }
}
