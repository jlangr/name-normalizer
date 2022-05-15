# name-normalizer

TDD Paint-by-Numbers exercise: Name Normalizer

The "paint-by-numbers" means you get to color in-between lines already drawn for you. In the case of TDD, that means the tests. **These are intended to be first TDD exercises.**

This is a great introductory way to learn about the incremental growth aspect of TDD (which isn't all that TDD is) by working through a family-friendly sequence of tests already specified for you. Thanks to James Grenning for the technique!

The primary things to focus on:

* Write no more code than needed to pass a test.
* If the test passes immediately, it's likely you wrote too much code in a prior step. (Or maybe you just forgot something silly, such as not compiling things.) If so, go back to the *beginning of the prior step.* Discard that effort, and think hard about a smaller implementation that would meet only the needs of the current set of tests.
* Refactor, refactor, refactor. With each passing test, ensure that you clean the code up and make it as readable as possible. If all your code ends up in the normalize method, chances are you can improve on it significantly. If you feel you need comments to explain the logic bits, chances are even better that you have code-focused opportunities for improvement.

Here is the complete set of instructions:

1. Ensure that the topmost test is enabled (i.e. ensure that it is not commented out, disabled, or otherwise marked as ignored).
1. Run your unit testing tool (e.g. JUnit, NUnit, xUnit.NET, CppUTest) against *all* tests in the project.
1. Did the test you just enabled fail? If not: You built too much code in a prior step. Undo work for prior tests and try again.
1. Make sure you are clear on why the test failed.
1. Write only enough code to make that failing test pass (and not break any other tests).
   Did you write too much? Is there a simpler way to get that test to pass???
1. Clean up whatever messes you made. Refactor. Ensure tests still pass.
1. If there is a second commented-out assertion in any test (rare!), uncomment it. It should fail. If not, return to step 5.
1. Repeat prior steps until no more test methods exist.

Currently this repo contains implementations in the following languages (contributor in parentheses):

* C# (Jeff Langr)
* C++ (gcc) (Jeff Langr)
* Clojure (Jeff Langr)
* Elixir (Kerry Buckley)
* Go (Akeshihiro)
* Java (Jeff Langr)
* JavaScript (Jeff Langr)
* Kotlin (Jon Reid)
* Objective-C (Jon Reid)
* Ruby (Jeff Langr)
* Rust (Akeshihiro)
* Swift (Jon Reid)

You can watch me derive a solution for the Java project at https://www.youtube.com/watch?v=OECwGP-bOwU.

Missing your favorite language? Please send me a pull request if you're able to supply at least the starter code. (I might be able to put together a few more myself, including Go, Groovy, Python, Rust, Smalltalk and Scala, though I could use a pair since these aren't languages I use often anymore.)
