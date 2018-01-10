exports.server =
    redis_port: process.env.REDIS_PORT || 6379
    redis_host: process.env.REDIS_HOST || 'localhost'
    tcp_port: process.env.PORT || 80
    udp_port: process.env.PORT || 80
    access_log: yes

exports['event-source'] =
    enabled: yes

exports['apns'] =
    enabled: yes
    class: require('./lib/pushservices/apns').PushServiceAPNS
    # Convert cert.cer and key.p12 using:
    # $ openssl x509 -in cert-prod.cer -inform DER -outform PEM -out apns-cert-prod.pem
    # $ openssl pkcs12 -in key-prod.p12 -out apns-key-prod.pem -nodes
    cert: 'certificates/push-cert-prod.pem'
    key: 'certificates/push-key-prod.pem'
    gateway: 'gateway.push.apple.com'
    address: 'feedback.push.apple.com'

# Uncomment to use same host for prod and dev
exports['apns-dev'] =
    enabled: yes
    class: require('./lib/pushservices/apns').PushServiceAPNS
    # Your dev certificats
    cert: 'certificates/push-cert-dev.pem'
    key: 'certificates/push-key-dev.pem'
    gateway: 'gateway.sandbox.push.apple.com'
    address: 'feedback.sandbox.push.apple.com'

exports['http'] =
    enabled: yes
    class: require('./lib/pushservices/http').PushServiceHTTP

exports['mpns-toast'] =
    enabled: no

exports['mpns-tile'] =
    enabled: no

exports['mpns-raw'] =
    enabled: no

exports["wns-toast"] =
    enabled: no

exports['gcm'] =
    enabled: no

# Transports: Console, File, Http
#
# Common options:
# level:
#   error: log errors only
#   warn: log also warnings
#   info: log status messages
#   verbose: log event and subscriber creation and deletion
#   silly: log submitted message content
#
# See https://github.com/flatiron/winston#working-with-transports for
# other transport-specific options.
exports['logging'] = [
    transport: 'Console'
    options:
        level: 'error'
]
