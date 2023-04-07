class V2rayConfig {
  Dns? dns;
  List<Inbounds>? inbounds;
  Log? log;
  List<Outbounds>? outbounds;
  Routing? routing;

  V2rayConfig(
      {this.dns, this.inbounds, this.log, this.outbounds, this.routing});

  V2rayConfig.fromJson(Map<String, dynamic> json) {
    dns = json['dns'] != null ? new Dns.fromJson(json['dns']) : null;
    if (json['inbounds'] != null) {
      inbounds = <Inbounds>[];
      json['inbounds'].forEach((v) {
        inbounds!.add(new Inbounds.fromJson(v));
      });
    }
    log = json['log'] != null ? new Log.fromJson(json['log']) : null;
    if (json['outbounds'] != null) {
      outbounds = <Outbounds>[];
      json['outbounds'].forEach((v) {
        outbounds!.add(new Outbounds.fromJson(v));
      });
    }
    routing =
    json['routing'] != null ? new Routing.fromJson(json['routing']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dns != null) {
      data['dns'] = this.dns!.toJson();
    }
    if (this.inbounds != null) {
      data['inbounds'] = this.inbounds!.map((v) => v.toJson()).toList();
    }
    if (this.log != null) {
      data['log'] = this.log!.toJson();
    }
    if (this.outbounds != null) {
      data['outbounds'] = this.outbounds!.map((v) => v.toJson()).toList();
    }
    if (this.routing != null) {
      data['routing'] = this.routing!.toJson();
    }
    return data;
  }

}
class Dns {
  Hosts? hosts;
  List<String>? servers;

  Dns({this.hosts, this.servers});

  Dns.fromJson(Map<String, dynamic> json) {
    hosts = json['hosts'] != null ? new Hosts.fromJson(json['hosts']) : null;
    servers = json['servers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hosts != null) {
      data['hosts'] = this.hosts!.toJson();
    }
    data['servers'] = this.servers;
    return data;
  }
}

class Hosts {
  String? domainGoogleapisCn;

  Hosts({this.domainGoogleapisCn});

  Hosts.fromJson(Map<String, dynamic> json) {
    domainGoogleapisCn = json['domain:googleapis.cn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domain:googleapis.cn'] = this.domainGoogleapisCn;
    return data;
  }
}

class Inbounds {
  String? listen;
  int? port;
  String? protocol;
  InBoundsSettings? settings;
  Sniffing? sniffing;
  String? tag;

  Inbounds(
      {this.listen,
        this.port,
        this.protocol,
        this.settings,
        this.sniffing,
        this.tag});

  Inbounds.fromJson(Map<String, dynamic> json) {
    listen = json['listen'];
    port = json['port'];
    protocol = json['protocol'];
    settings = json['settings'] != null
        ? new InBoundsSettings.fromJson(json['settings'])
        : null;
    sniffing = json['sniffing'] != null
        ? new Sniffing.fromJson(json['sniffing'])
        : null;
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['listen'] = this.listen;
    data['port'] = this.port;
    data['protocol'] = this.protocol;
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    if (this.sniffing != null) {
      data['sniffing'] = this.sniffing!.toJson();
    }
    data['tag'] = this.tag;
    return data;
  }
}

class InBoundsSettings {
  String? auth;
  bool? udp;
  int? userLevel;

  InBoundsSettings({this.auth, this.udp, this.userLevel});

  InBoundsSettings.fromJson(Map<String, dynamic> json) {
    auth = json['auth'];
    udp = json['udp'];
    userLevel = json['userLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auth'] = this.auth;
    data['udp'] = this.udp;
    data['userLevel'] = this.userLevel;
    return data;
  }
}

class Sniffing {
  List<String>? destOverride;
  bool? enabled;

  Sniffing({this.destOverride, this.enabled});

  Sniffing.fromJson(Map<String, dynamic> json) {
    destOverride = json['destOverride'].cast<String>();
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['destOverride'] = this.destOverride;
    data['enabled'] = this.enabled;
    return data;
  }
}

class Log {
  String? loglevel;

  Log({this.loglevel});

  Log.fromJson(Map<String, dynamic> json) {
    loglevel = json['loglevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loglevel'] = this.loglevel;
    return data;
  }
}

class Outbounds {
  Mux? mux;
  String? protocol;
  OutboundsSettings? settings;
  StreamSettings? streamSettings;
  String? tag;

  Outbounds(
      {this.mux, this.protocol, this.settings, this.streamSettings, this.tag});

  Outbounds.fromJson(Map<String, dynamic> json) {
    mux = json['mux'] != null ? new Mux.fromJson(json['mux']) : null;
    protocol = json['protocol'];
    settings = json['settings'] != null
        ? new OutboundsSettings.fromJson(json['settings'])
        : null;
    streamSettings = json['streamSettings'] != null
        ? new StreamSettings.fromJson(json['streamSettings'])
        : null;
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mux != null) {
      data['mux'] = this.mux!.toJson();
    }
    data['protocol'] = this.protocol;
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    if (this.streamSettings != null) {
      data['streamSettings'] = this.streamSettings!.toJson();
    }
    data['tag'] = this.tag;
    return data;
  }
}

class Mux {
  int? concurrency;
  bool? enabled;

  Mux({this.concurrency, this.enabled});

  Mux.fromJson(Map<String, dynamic> json) {
    concurrency = json['concurrency'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['concurrency'] = this.concurrency;
    data['enabled'] = this.enabled;
    return data;
  }
}

class OutboundsSettings {
  List<Servers>? servers;
  Response? response;

  OutboundsSettings({this.servers, this.response});

  OutboundsSettings.fromJson(Map<String, dynamic> json) {
    if (json['servers'] != null) {
      servers = <Servers>[];
      json['servers'].forEach((v) {
        servers!.add(new Servers.fromJson(v));
      });
    }
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.servers != null) {
      data['servers'] = this.servers!.map((v) => v.toJson()).toList();
    }
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Servers {
  String? address;
  int? level;
  String? method;
  bool? ota;
  String? password;
  int? port;

  Servers(
      {this.address,
        this.level,
        this.method,
        this.ota,
        this.password,
        this.port});

  Servers.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    level = json['level'];
    method = json['method'];
    ota = json['ota'];
    password = json['password'];
    port = json['port'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['level'] = this.level;
    data['method'] = this.method;
    data['ota'] = this.ota;
    data['password'] = this.password;
    data['port'] = this.port;
    return data;
  }
}

class Response {
  String? type;

  Response({this.type});

  Response.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    return data;
  }
}

class StreamSettings {
  String? network;
  String? security;

  StreamSettings({this.network, this.security});

  StreamSettings.fromJson(Map<String, dynamic> json) {
    network = json['network'];
    security = json['security'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['network'] = this.network;
    data['security'] = this.security;
    return data;
  }
}

class Routing {
  String? domainMatcher;
  String? domainStrategy;
  List<Rules>? rules;

  Routing({this.domainMatcher, this.domainStrategy, this.rules});

  Routing.fromJson(Map<String, dynamic> json) {
    domainMatcher = json['domainMatcher'];
    domainStrategy = json['domainStrategy'];
    if (json['rules'] != null) {
      rules = <Rules>[];
      json['rules'].forEach((v) {
        rules!.add(new Rules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domainMatcher'] = this.domainMatcher;
    data['domainStrategy'] = this.domainStrategy;
    if (this.rules != null) {
      data['rules'] = this.rules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rules {
  List<String>? ip;
  String? outboundTag;
  String? port;
  String? type;

  Rules({this.ip, this.outboundTag, this.port, this.type});

  Rules.fromJson(Map<String, dynamic> json) {
    ip = json['ip'].cast<String>();
    outboundTag = json['outboundTag'];
    port = json['port'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ip'] = this.ip;
    data['outboundTag'] = this.outboundTag;
    data['port'] = this.port;
    data['type'] = this.type;
    return data;
  }
}

