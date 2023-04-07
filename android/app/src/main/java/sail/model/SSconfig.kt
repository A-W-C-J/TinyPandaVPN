package sail.model

data class SSconfig(
    var address: String,
    var amux: Any,
    var amuxCon: Any,
    var amuxMax: Any,
    var encryptMethod: String,
    var `interface`: Any,
    var password: String,
    var protocol: String,
    var quic: Any,
    var sni: Any,
    var tag: String,
    var tls: Any,
    var tlsCert: Any,
    var username: Any,
    var ws: Any,
    var wsHost: Any,
    var wsPath: Any,
    var port: Int
)