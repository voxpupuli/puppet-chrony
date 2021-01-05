# @summary Function to normalise servers/pools/peers
#
# @api private
function chrony::server_array_to_hash(Variant[Hash,Array] $servers, $options = []) >> Hash {
  if $servers.is_a(Hash) {
    $servers
  } else {
    $servers.reduce({}) |$memo, $server| { # lint:ignore:manifest_whitespace_opening_brace_before
      $memo + { $server => $options }
    }
  }
}
