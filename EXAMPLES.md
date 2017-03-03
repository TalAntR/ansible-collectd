
# Using EPEL repo for installation

    - hosts: all
      roles:
        - role: collectd
          collectd_version: 5.6.0
          collectd:

            # EPEL repo is used for this installation
            providers:
              pkg:
                repositories:
                  Collectd:
                    enabled: no
                prerequisites:
                  - epel-release
                packages:
                  - collectd
                  - collectd-netlink

            service:
              options:
                FQDNLookup: false

            plugins:
              write_graphite:
                file: graphite
                enabled: true
                options:
                  Node "ssp-carbon-relay":
                    Host: "{{ groups['collectd-gw'] | first }}"
                    Port: "2003"
                    Prefix: "epiphany.ssp.prod.us-east.ec2."
                    LogSendErrors: true
                    Protocol: "udp"
                    EscapeCharacter: "_"
                    SeparateInstances: true
                    StoreRates: false
                    AlwaysAppendDS: false
