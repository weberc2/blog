---
Title: Exposing Kubernetes service to LAN
Date: 2024-07-01
Tags: [homelab, kubernetes, tailscale, media]
---

As 🇺🇸🦅🆓 day approaches, I've been wanting to introduce my wife to [the 1996
Will Smith film by the same
name](https://en.wikipedia.org/wiki/Independence_Day_(1996_film)). I have the
film on an external hard drive, hooked up to my [Jellyfin](https://jellyfin.org)
media server which is accessible on my [Tailscale](https://tailscale.com) VPN
("tailnet" in Tailscale parlance). However, neither our smart TVs nor our router
support Tailscale, so I needed to figure out how to expose my media server
(which is running as a Kubernetes service) to my LAN. This post will lay out my
solution.

<!-- more -->

# Other approaches

Before diving into my solution, there are some other ways to approach the
problem that *might* be more convenient for readers.

* Bridge LAN and Tailscale networks. If you have a router which supports static
  route assignments (unlike mine), you can designate a node in your network to
  be a bridge between the two networks. When a smart TV wants to talk to my
  media server running in my tailscale network, the router would direct it to
  the bridge node which would forward the traffic into my tailnet.

* Install Tailscale on your router. This will effectively bridge the networks
  in the same way as (1) except the router will be the bridge. Unfortunately,
  most routers probably don't support tailscale, so this is mostly just here for
  sake of completeness.

* If you aren't running your media server on Kubernetes in the first place, you
  should just be able to tell your media server to listen to all traffic on the
  host network regardless of which interface it is coming from. The rest of this
  guide won't apply to you. 🙃

# My approach

My approach was to create a new ingress controller using a modified
`ingress-nginx`. The new ingress controller will run pods on each node in the
cluster, and the pods will listen for traffic on the host network (on ports 80
and 443) and forward that traffic to the internal Kubernetes services based on
the Ingress resources' configuration.

## Configuring `ingress-nginx`

To make the new ingress controller, I started with the latest copy of the
`ingress-nginx`
[manifests](https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/v3.6.0/deploy/crds.yaml)
(v3.6.0 at the time of this writing) and made the following changes:

* Replace the `ingress-nginx-controller` Deployment resource with a DaemonSet so
  there is a pod running on each node in the cluster.

* Add `hostNetwork: true` to the `ingress-nginx-controller` DaemonSet's pod spec
  so each pod listens on the host network.

* Delete the `ingress-nginx-controller` Service resource, which isn't necessary
  since the pods themselves are the entrypoint to the ingress.

## Create media server ingress object

With the ingress controller configured to listen on LAN, I needed to create an
Ingress object which told it to direct traffic from LAN into the media server
service. In my case, I'm directing any port 80 or 443 traffic directly to the
jellyfin service, but if I had DNS configured I would put a host filter on it (I
may still put a path filter, so traffic has to have a `/jellyfin` prefix or
similar).

To tell the ingress object to use the new ingress controller, we set
the `.spec.ingressClassName` to match the ingress controller (in my case, the
new ingress class is just called `nginx`).

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  namespace: jellyfin
  name: nginx
spec:
  ingressClassName: nginx
  rules:
  - http:
      paths:
      - backend:
          service:
            name: jellyfin
            port:
              # Jellyfin listens on 8096 by default
              number: 8096
        path: /
        pathType: Prefix
```
