---
Title: "Exposing my Tailscale/Kubernetes Media Server to LAN"
Date: 2024-06-26
Tags: [homelab, kubernetes, tailscale, media]
---

I've been running [Jellyfin](https://jellyfin.org), a Plex-like media server, on
my Tailscale VPN ("tailnet" in Tailscale parlance) for several months, but
because this is running on my Kubernetes cluster which itself was running
entirely in Tailscale, I didn't have a good way to watch it from my smart TVs
which don't support joining a tailnet. Now however, I still don't have a _good_
way to connect to my media server from my smart TVs, but I do have _a_ way which
I'll detail shortly.

<!-- more -->

# Try this first

Before getting into my solution, let's talk about saner solutions that you
should look into before my cursed solution, and why those saner solutions don't
work for me.

Firstly, if your TV doesn't support connecting to your VPN, check to see if your
router does--if so, you may be able to connect your entire network to your VPN
with minimal headache. Of course, I have a TP-Link Deco series router which does
not support Tailscale, and as far as I know none of the hundreds of models in
this series do either (seriously, why are there so many cryptically named models
of a consumer router???).

Failing that, check to see if your router supports static routes. If so, you can
designate a Raspberry Pi or some other node in your network to be a bridge
between your tailnet and your LAN--when devices on your LAN send packets with a
tailnet IP address, your router will direct them to your bridge node which will
forward them into your tailnet (and vice versa for devices in your tailnet
trying to reach your LAN). This time there are _many_ models of Deco routers
which do support static routes, but unfortunately I invested in one which
doesn't. Further, since it's a mesh network, I don't really want to have to
replace all of the hardware and while mixing the hardware is possible, I really
don't know what it would do since different hardware support different features.

Lastly, buy an Apple TV or some similar media player and use your "smart TV"
like a dumb display. Apple TVs can connect to Tailscale and--more importantly
for me--they have plenty of power to transcode media on the fly: smart TVs
typically only support a small number of codecs, and if your media isn't encoded
with one of those on disk then the media server will typically try to transcode
it on the fly--transcoding media in real time requires a powerful computer or
specialized hardware, and my Raspberry Pi 4Bs match neither criteria. Further,
you can take this on vacation (even internationally) and play your media like
you were in your living room (if you are traveling internationally and would
like to access other geo-restricted streaming services, you may need to
designate an exit node that stays on your local network). I'll probably go the
Apple TV route eventually, mostly because it's the best way I've found to work
around the transcoding restrictions.

# What I did

To make matters a little more complicated, I'm running Jellyfin on my Kubernetes
cluster, which is running inside my tailnet--despite being connected on the same
LAN, the nodes all talk to each other via their Tailscale IP addresses rather
than their physical LAN addresses. Within my tailnet, Jellyfin has its own
Tailscale IP address (distinct from the Tailscale IP address of the node that it
is running on) and DNS, but it's completely inaccessible to the LAN.

## External ingress controller

To make Jellyfin listen on LAN, I created a new ingress resource for it, backed
by a modified `ingress-nginx` Ingress controller. Specifically, I'm changing the
podspecs so each pod has its `hostNetwork: true`--this means the ingress
controller will accept traffic from the LAN (or tailnet) on whichever node it is
running on.  To make sure there is a pod running on each node, I've replaced the
`Deployment` resource with a `DaeomonSet` resource. Lastly, since the pods are
taking traffic directly from the hosts they're running on, there's no need for
the `ingress-nginx-controller` `Service` resource, so I deleted it.

## External ingress object

The Ingress resource I created for Jellyfin just binds port 8096 (the default
Jellyfin port) to port 80 and accepts traffic destined for all hosts. The result
is that any port 80 traffic sent to any of the nodes in my cluster is directed
to the Jellyfin service. In the future, I might restrict this so that only
traffic to certain hosts, or perhaps with a `/jellyfin` path (or similar) gets
sent to Jellyfin, but for now it's the only service that needs LAN access.

## Connecting via smart TV

To make a smart TV or other device on my LAN network talk to the Jellyfin
service, I use `http://<node-ip>` where `<node-ip>` is the IP address of any
node in my cluster. If one node goes down, I can replace it with the address of
any other node, although presently all of my media is on a single hard drive so
if something happens to that node I'm still in trouble--I'll try to shore this
up sometime in the future.

## Next Steps

In the future, I'll probably scrap all of this and buy a couple Apple TVs so I
can do away with the restrictions imposed by so-called smart TVs. If I don't do
that, I'll probably put Jellyfin on `http://<node-ip>/jellyfin` or similar, so I
can have other services listening on the LAN. Lastly, I may add some DNS so I
don't have to type an IP address in, which is especially painful to enter with a
TV remote.

# Conclusion

The crux of the problem was that my cluster had a Kubernetes Ingress controller
for exposing services via Tailscale, and the solution was creating a new Ingress
controller which exposed them to the LAN.