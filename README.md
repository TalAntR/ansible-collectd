# ansible-collectd


An example for ansible playbook for collectd agent:

        - hosts: all
          roles:
            - role: collectd
              collectd_version: 5.5.1
              collectd:
                service:
                  options:
                    FQDNLookup: false
                plugins:
                  write_graphite:
                    enabled: true
                    options:
                      Node "tt-graphite-omsk":
                        Host: "graphite-dev.example.lo"
                        LogSendErrors: true
                        Port: "2103"
                        Prefix: "collectd."
                        Protocol: "tcp"
                        EscapeCharacter: "_"
                        SeparateInstances: true
                        StoreRates: false
                        AlwaysAppendDS: false

