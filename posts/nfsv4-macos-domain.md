---
Title: NFSv4 macOS Domain Configuration
Date: 2025-02-18
Tags: [macOS, nfs]
---

I've seen dozens of questions on the Internet about how to allow macOS users to
edit files on their NFSv4 shares, but almost nowhere have I found any answers. I
finally figured it out for myself, so I want to document it for others.

<!--more-->

When the ID mapping does not work properly, you will typically be able to read
files but not write to them, even if your username and UID is the same on both
the client and the server.

NFSv4 doesn't send UIDs from the client to the server, but rather it sends a
fully qualified username: `USERNAME@DOMAINNAME`. This means that even if you
have a user `foo` with UID `501` on both macOS and your NFS server, that user
will not be able to access files owned by the server's `foo/501` user by
default, because macOS does not use the same domain name as the server by
default.

The default domain name for Linux NFS servers is `localdomain`, and by default
macOS chooses a domain name based on the wifi network identifier (e.g., I'm at
the library, and I see my library's wifi identifier in my default domain name).
So the server is expecting `foo@localdomain`, but macOS is sending
`foo@some-other-domain`. You can see what user@domain the server is sending by 
running:

```bash
$ sudo nfs4mapid -u $UID
Password:
user id 501 maps to foo@some-other-domain
```

To change the domain name, you only need to add the following to
`/etc/nfs.conf` on macOS:

```
nfs.client.default_nfs4domain=localdomain
```

On my system, I was immediately able to edit files owned by UID=501 without
restarting any daemons or unmounting/remounting the NFSv4 share.

**IMPORTANT** Make sure you're mounting with NFSv4 by passing the `vers=4` mount option. My mount command looks like this: `mount -t nfs -o resvport,vers=4 $SERVER:$SHARE $MOUNTPOINT`.