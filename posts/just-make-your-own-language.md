---
Title: Just make your own language
Date: 2024-05-02
Tags: [rust, c, c++, culture]
---

I've been programming since the early 2000s. I started in PHP, and then learned
Java, Python, C, and C++. In the early days especially, programming communities
were super toxic. If you had questions and didn't read The Correct Textbook
About The Blessed Programming Language™️, you would be berated. If you *did* read
said textbook and it didn't address your question, you would *still* be berated
for trying to do something outside of the instruction of The Correct Textbook
(if The Correct Textbook™️ doesn't discuss it, then you don't need it, heretic!).

One of my least favorite forms of toxicity (albeit not necessarily the most
toxic) was when someone would try to advocate for the need for a feature in C or
C++[^1], (for example, a standard build tool with dependency management). The
refrain almost always included a snarky, "if you don't like The Language™️, feel
free to create your own!"--knowing full well the absurdity of expecting a new
programmer to master programming language design and then implement a
programming language and also market it so that enough other people use it that
it acquires enough marketshare that there are jobs available for using that
language and also an ecosystem of libraries and tools for it--all so that said
programmer can reliably build projects or address whatever other issue was
lacking from the original language. And naturally I did try to make my own
language a few times before realizing the investment required and how much I
would need to learn to have a nonzero chance of succeeding.

Anyway, skip ahead a few decades and now many in those same communities are now
aggrieved that someone actually managed to do exactly what they snarkily
suggested: Mozilla built Rust which addresses many of the issues that C and C++
programmers have had with their respective languages, but which their
communities refused to take seriously. And not only that, but now people are
advocating for the *rewriting of the C and C++ ecosystem in Rust*, and many[^0]
in the C and C++ communities are having none of it. The sacrilege! *Sacré bleu*!

I'm not a Rust fanboy--I think it's an improvement over C and C++, and I like a
lot about it, but it's not likely to be my main language any time soon. And
moreover the Rust community has its own foibles that chafe me (criticizing a
certain other language without ever actually analyzing *why* people are drawn to
and retained by said language in the first place 🙃). I also think "rewrite it
in Rust" is pretty facile--it's often a lazy substitute for a reasoned
cost/benefit analysis. Even still, I appreciate that the whole "rewrite it in
rust" phenomenon *might* make some C and C++ loyalists a little less likely to
berate their fellow language enthusiasts when concerns are raised[^2].

[^0]: Not all or necessarily even a majority. Ideally that would be implicit in
      "many", but somehow I find myself needing to caveat these things...

[^1]: Whenever I mention C and C++ in the same breath, some will ignore
      everything else I wrote so as to deflect to "C and C++ are different
      languages" as though that is somehow not incumbent in referring to them by
      different names. 🙃

[^2]: Please note that my optimism about they hypothetical decrease in toxicity
      in the C and C++ communities is not the same thing as reveling in a
      hypothetical decline in either language's market share or some such thing.