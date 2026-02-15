{ globals, pkgs, ... }:
let
  # vpn namespace
  ns = "vpn";

  # physical interface identifiers
  # internet sharing over wireguard vpn from lanDev to auxDev
  # local network sharing from lanDev to auxDev
  lanDev = "end0";
  auxDev = "enu1c2";

  # arbitrary device identifiers
  wgDev = "wg0";
  vethMainDev = "veth-main";
  vethNsDev = "veth-ns";

  # wireguard configuration
  wgConfigFile = "${globals.homeDir}/.vpn/default.conf";
  wgIpv4 = "10.72.19.0/32";
  wgIpv6 = "fc00:bbbb:bbbb:bb01::9:12ff/128";

  # arbitrary ips for virtual ethernet connection between root namespace
  # and vpn namespace
  vethMainDevIpv4 = "10.0.1.1";
  vethNsDevIpv4 = "10.0.1.2";

  # static ip for auxDev
  # must be set as default gateway on the other end of the cable
  auxDevIpv4 = "10.0.0.1";

  # lan ip address range to be accessed from auxDev
  lanIpv4 = "192.168.178.0/24";

  # transmission
  transmissionDownloadDir = "${globals.homeDir}/transmission";
in
{
  environment.systemPackages = [ pkgs.wireguard-tools ];

  networking.firewall.allowedUDPPorts = [ 51820 ]; # wireguard

  # allow ip forwarding
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  boot.kernel.sysctl."net.ipv4.conf.all.forwarding" = 1;

  # services.transmission = {
  #   enable = true;
  #   openRPCPort = true;
  #   user = "${globals.username}";
  #   settings = {
  #     # download-dir = transmissionDownloadDir;
  #     incomplete-dir-enabled = false;
  #     rpc-bind-address = "0.0.0.0";
  #     rpc-whitelist-enabled = false;
  #   };
  # };

  systemd.services = {
    # creates vpn namespace
    "${ns}" = {
      after = [ "network-pre.target" ];
      before = [ "network.target" "network-online.target" ];
      wantedBy = [ "network-online.target" "multi-user.target" ];
      path = with pkgs; [ iproute2 util-linux ];

      # mount the netns of service with a named one for use elsewhere
      script = ''
        set -x
        ip netns delete ${ns} || :
        ip netns add ${ns}
        umount /var/run/netns/${ns}
        mount --bind /proc/self/ns/net /var/run/netns/${ns}
      '';

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        PrivateNetwork = true;
        PrivateMounts = false;
        ExecStop = "${pkgs.iproute2}/bin/ip netns del ${ns}";
      };
    };

    # starts wireguard in vpn namespace
    "${ns}-wireguard" = {
      wantedBy = [ "multi-user.target" ];
      path = with pkgs; [ iproute2 iptables wireguard-tools ];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };

      unitConfig = {
        BindsTo = "${ns}.service";
        After = "${ns}.service";
      };

      script = ''
        set -x

        # create wireguard device start it in vpn namespace
        ip link del ${wgDev} || :
        ip link add ${wgDev} type wireguard
        ip link set ${wgDev} netns ${ns} || true
        ip -n ${ns} addr add ${wgIpv4} dev ${wgDev} || true
        ip -n ${ns} addr add ${wgIpv6} dev ${wgDev} || true
        ip netns exec ${ns} wg setconf ${wgDev} ${wgConfigFile}
        ip -n ${ns} link set ${wgDev} up

        # set wireguard as default route for vpn namespace
        ip -n ${ns} route add default dev ${wgDev} || true
        ip -n ${ns} -6 route add default dev ${wgDev} || true

        # create a virtual ethernet pair between root and vpn namespaces
        ip link del ${vethMainDev} || :
        ip link del ${vethNsDev} || :
        ip link add ${vethMainDev} type veth peer name ${vethNsDev}
        ip link set ${vethNsDev} netns ${ns} || true

        # set ip address of veth pair
        ip addr add ${vethMainDevIpv4}/24 dev ${vethMainDev} || true
        ip link set ${vethMainDev} up
        ip -n ${ns} addr add ${vethNsDevIpv4}/24 dev ${vethNsDev} || true
        ip -n ${ns} link set ${vethNsDev} up

        # add route to reach lan from vpn namespace through the virtual ethernet pair
        ip -n ${ns} route add ${lanIpv4} via ${vethMainDevIpv4} dev ${vethNsDev}

        # route traffic coming from veth through the lan device
        iptables -t nat -A POSTROUTING -s ${vethMainDevIpv4}/24 -o ${lanDev} -j MASQUERADE
      '';
    };

    # lan and vpn sharing with auxDev
    "${ns}-wireguard-sharing" = {
      wantedBy = [ "multi-user.target" ];
      path = with pkgs; [ iptables iproute2 sysctl ];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };

      unitConfig = {
        BindsTo = "${ns}-wireguard.service";
        After = "${ns}-wireguard.service";
      };

      script = ''
        set -x

        # move auxDev to the vpn namespace
        ip link set ${auxDev} netns ${ns} || true
        ip -n ${ns} addr add ${auxDevIpv4}/24 dev ${auxDev} || true
        ip -n ${ns} link set ${auxDev} up

        # route all traffic in the namespace through the vpn
        ip netns exec ${ns} iptables -t nat -A POSTROUTING -o ${wgDev} -j MASQUERADE

        # except for traffic meant for lan - this goes over veth
        ip netns exec ${ns} iptables -t nat -A POSTROUTING -d ${lanIpv4} -o ${vethNsDev} -j MASQUERADE
      '';
    };
  };
}
