---
Title: Some History of JVM and WASM
Date: 2025-02-27
Tags: [java, wasm]
---

I came across a thread on HackerNews recently, about why WASM was built rather
than relying on the JVM which seemed to have similar sandboxing goals. The
specific question was ([link](https://news.ycombinator.com/item?id=43184385)):

> I thought Java had all of this sandboxing stuff baked in? Wasn't that a big
> selling point for the JVM once upon a time? Every other WASM thread has
> someone talking about how WASM is unnecessary because JVM exists, so the idea
> that JVM actually needs WASM to do sandboxing seems pretty surprising!

[John Millikin](https://john-millikin.com/) provided an excellent response
[here](https://news.ycombinator.com/item?id=43189509) that seemed worth sharing:

<!-- more -->

> The JVM was designed with the intention of being a secure sandbox, and a lot
> of its early adoption was as Java applets that ran untrusted code in a browser
> context. It was a serious attempt by smart people to achieve a goal very
> similar to that of WebAssembly.
> 
> Unfortunately Java was designed in the 1990s, when there was much less
> knowledge about software security -- especially sandboxing of untrusted code.
> So even though the goal was the same, Java's design had some flaws that made
> it difficult to write a secure JVM.
> 
> The biggest flaw (IMO) was that the sandbox layer was internal to the VM: in
> modern thought the VM is the security boundary, but the JVM allows trusted and
> untrusted code to execute in the same VM, with java.lang.SecurityManager[0]
> and friends as the security mechanism. So the attack surface isn't the
> bytecode interpreter or JIT, it's the entire Java standard library plus every
> third-party module that's linked in or loaded.
> 
> During the 2000s and 2010s there were a lot of Java sandbox escape CVEs. A
> representative example is
> <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2013-0422>. Basically the
> Java security model was broken, but fixing it would break backwards
> compatibility in a major way.
> 
> --
> 
> Around the same time (early-mid 2010s) there more thought being put into
> sandboxing native code, and the general consensus was:
> 
> - Sandboxing code within the same process space requires an extremely
> restricted API. The original seccomp only allowed read(), write(), exit(), and
> sigreturn() -- it could be used for distributed computation, but compiling
> existing libraries into a seccomp-compatible dylib was basically impossible.
> 
> - The newly-developed virtualization instructions in modern hardware made it
> practical to run a virtual x86 machine for each untrusted process. The
> security properties of VMs are great, but the x86 instruction set has some
> properties that make it difficult to verify and JIT-compile, so actually
> sitting down and writing a secure VM was still a major work of engineering
> (see: QEMU, VMWare, VirtualBox, and Firecracker).
> 
> Smartphones were the first widespread adoption of non-x86 architectures among
> consumers since PowerPC, and every smartphone had a modern web browser built
> in. There was increasing desire to have something better than JavaScript for
> writing complex web applications executing in a power-constrained device. Java
> would have been the obvious choice (this was pre-Oracle), except for the
> sandbox escape problem.
> 
> WebAssembly combines architecture-independent bytecode (like JVM) with the
> security model of VMs (flat memory space, all code in VM untrusted). So you
> can take a whole blob of legacy C code, compile it to WebAssembly, and run it
> in a VM that runs with reasonable performance on any architecture (x86, ARM,
> RISC-V, MIPS, ...). 