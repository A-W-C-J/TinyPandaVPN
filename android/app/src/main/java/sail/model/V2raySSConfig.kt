package sail.model

data class V2raySSConfig(
    var dns: Dns,
    var fakedns: List<Fakedn>,
    var inbounds: List<Inbound>,
    var log: Log,
    var outbounds: List<Outbound>,
    var policy: Policy,
    var routing: Routing,
    var stats: Stats
)

data class Dns(
    var hosts: Hosts,
    var servers: List<String>
)

data class Fakedn(
    var ipPool: String,
    var poolSize: Int
)

data class Inbound(
    var listen: String,
    var port: Int,
    var protocol: String,
    var settings: Settings,
    var sniffing: Sniffing,
    var tag: String
)

data class Log(
    var loglevel: String
)

data class Outbound(
    var mux: Mux,
    var protocol: String,
    var settings: SettingsX,
    var streamSettings: StreamSettings,
    var tag: String
)

data class Policy(
    var levels: Levels,
    var system: System
)

data class Routing(
    var domainStrategy: String,
    var rules: List<Rule>
)

class Stats

data class Hosts(
    var domain: String
)

data class Settings(
    var auth: String,
    var udp: Boolean,
    var userLevel: Int
)

data class Sniffing(
    var destOverride: List<String>,
    var enabled: Boolean
)

data class Mux(
    var concurrency: Int,
    var enabled: Boolean
)

data class SettingsX(
    var domainStrategy: String,
    var response: Response,
    var servers: List<Server>
)

data class StreamSettings(
    var network: String,
    var security: String
)

data class Response(
    var type: String
)

data class Server(
    var address: String,
    var level: Int,
    var method: String,
    var ota: Boolean,
    var password: String,
    var port: Int
)

data class Levels(
    var `8`: X8
)

data class System(
    var statsOutboundDownlink: Boolean,
    var statsOutboundUplink: Boolean
)

data class X8(
    var connIdle: Int,
    var downlinkOnly: Int,
    var handshake: Int,
    var uplinkOnly: Int
)

data class Rule(
    var ip: List<String>,
    var outboundTag: String,
    var port: String,
    var type: String
)