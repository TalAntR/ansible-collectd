
# Using EPEL repo for installation

    - hosts: all
      roles:
        - role: collectd
          versions:
            collectd: 5.8.1
          collectd:

            # EPEL repo is used for this installation
            providers:
              pkg:
                repositories:
                  # Disable collectd CI repository which is default.
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
                  Node "carbon-relay":
                    Host: "{{ groups['collectd-gw'] | first }}"
                    Port: "2003"
                    Prefix: "owner.project.prod.us-east.ec2."
                    LogSendErrors: true
                    Protocol: "udp"
                    EscapeCharacter: "_"
                    SeparateInstances: true
                    StoreRates: false
                    AlwaysAppendDS: false
