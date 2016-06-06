# ansible-collectd


- hosts: all
  roles:
    - role: collectd
      collectd_version: 5.5.1.156.g22651d8
      collectd:
        service:
          options:
            FQDNLookup: false
        plugins:
          write_graphite:
            enabled: true
            options:
              Node "tt-graphite-omsk":
                Host: "graphite-dev.thumbtack.lo"
                LogSendErrors: true
                Port: "2103"
                Prefix: "thumbtack.omsk.esx."
                Postfix: "-noserver-1"
                Protocol: "tcp"
                EscapeCharacter: "_"
                SeparateInstances: true
                StoreRates: false
                AlwaysAppendDS: false

