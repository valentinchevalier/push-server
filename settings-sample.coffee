exports.server =
    redis_port: process.env.REDIS_PORT || 6379
    redis_host: process.env.REDIS_HOST || 'localhost'
    redis_auth: process.env.REDIS_AUTH || undefined
    tcp_port: process.env.PORT || 80
    udp_port: process.env.PORT || 80
    access_log: yes

exports['event-source'] =
    enabled: yes

exports['apns'] =
    enabled: yes
    class: require('./lib/pushservices/apns').PushServiceAPNS
    cert: 'certificates/apns-cert-prod.pem'
    key: 'certificates/apns-key-prod.pem'
    gateway: 'gateway.push.apple.com'
    address: 'feedback.push.apple.com'

exports['apns-dev'] =
    enabled: yes
    class: require('./lib/pushservices/apns').PushServiceAPNS
    cert: 'certificates/apns-cert-dev.pem'
    key: 'certificates/apns-key-dev.pem'
    gateway: 'gateway.sandbox.push.apple.com'
    address: 'feedback.sandbox.push.apple.com'

exports['http'] =
    enabled: yes
    class: require('./lib/pushservices/http').PushServiceHTTP

exports['gcm'] =
    enabled: no
    # enabled: yes
    # class: require('./lib/pushservices/gcm').PushServiceGCM
    # key: 'GCM API KEY HERE'
    # #options:
    #    #proxy: 'PROXY SERVER HERE'

exports['mpns-toast'] =
    enabled: no

exports['mpns-tile'] =
    enabled: no

exports['mpns-raw'] =
    enabled: no

exports["wns-toast"] =
    enabled: no

# Transports: Console, File, Http
# level: error, warn, info, verbose, silly
exports['logging'] = [
    transport: 'Console'
    options:
        level: 'error'
]
