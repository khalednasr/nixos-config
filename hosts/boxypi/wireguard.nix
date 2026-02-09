{ globals, pkgs, ... }:
let
  ns = "vpn";
  internetDev = "end0";
  auxDev = "enu1c2";
  wgDev = "wg0";
  wgConfigFile = "${globals.homeDir}/.vpn/nl-ams-wg-008.conf";
  wgIpv4 = "10.72.19.0/32";
  wgIpv6 = "fc00:bbbb:bbbb:bb01::9:12ff/128";
  auxDevIpv4 = "10.0.0.1/24";
in
{
  environment.systemPackages = [ pkgs.wireguard-tools ];

  networking.firewall.allowedUDPPorts = [ 51820 ];

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  boot.kernel.sysctl."net.ipv4.conf.all.forwarding" = 1;
  boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = 1;

  systemd.services = {
    "${ns}" = {
      after = [ "network-pre.target" ];
      before = [ "network.target" "network-online.target" ];
      wantedBy = [ "network-online.target" "multi-user.target" ];
      path = with pkgs; [ iproute2 util-linux ];

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

    "${ns}-wireguard" = {
      wantedBy = [ "multi-user.target" ];
      path = with pkgs; [ iproute2 wireguard-tools ];

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
        ip link del ${wgDev} || :
        ip link add ${wgDev} type wireguard
        ip link set ${wgDev} netns ${ns} || true
        ip -n ${ns} addr add ${wgIpv4} dev ${wgDev} || true
        ip -n ${ns} addr add ${wgIpv6} dev ${wgDev} || true
        ip netns exec ${ns} wg setconf ${wgDev} ${wgConfigFile}
        ip -n ${ns} link set ${wgDev} up
        ip -n ${ns} route add default dev ${wgDev}
      '';
    };

    "${ns}-wireguard-sharing" = {
      wantedBy = [ "multi-user.target" ];
      path = with pkgs; [ iptables iproute2 ];

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
        ip link set ${auxDev} netns ${ns} || true
        ip -n ${ns} addr add ${auxDevIpv4} dev ${auxDev} || true
        ip -n ${ns} link set ${auxDev} up

        ip netns exec ${ns} iptables -t nat -A POSTROUTING -o ${wgDev} -j MASQUERADE
        ip netns exec ${ns} iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
        ip netns exec ${ns} iptables -A FORWARD -i ${auxDev} -o ${wgDev} -j ACCEPT
      '';
    };
  };
}
