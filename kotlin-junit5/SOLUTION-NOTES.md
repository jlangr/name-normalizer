# Notes for Example Solution using Kotlin and JUnit 5

The TDD examples I have found most useful came with detailed commentary that gave me valuable insights about problem solving, design, refactoring, and testing. These are some of the authors whose work helped me learn and improve my TDD:
* *Refactoring* by Martin Fowler
* *Understanding the Four Rules of Simple Design* by Corey Haines
* *Pragmatic Unit Testing with Java and JUnit* by Jeff Langr
* *Working Effectively with Legacy Code* by Michael Feathers
* *Tidy First?* by Kent Beck

I hope you find something useful in this example and these notes, too.

—Junilu Lacar (May 2025)

## Commit cadence

When you're doing TDD you typically commit when the tests go green, i.e., they all pass. However, to make it easier to follow this example solution, I committed at each completed step of the TDD cycle, including red, when tests were failing. I added notes to this document to explain the rationale behind the changes in that commit. There will also be a few commits where only commentary was added to this document; those commits will be denoted by a documentation intention (see next section).

## Commit notation used

I'm using Arlo Belshee's Commit Message Notation, a detailed description of which you can find here:
https://github.com/RefactoringCombos/ArlosCommitNotation

The main commit intentions I use for this example are:
- `d` - documentation only
- `t` - only tests were changed
- `F` - functionality added or changed
- `r` - refactoring

The risk markers I use:
- `.` - (Proven) Safe
- `^` - Validated
- `!` - Risky
- `@` - (Probably) Broken

Example commit message: `. d Add solution notes`

# Detailed TDD Notes

## Getting started

Before starting TDD, run the existing tests to confirm that the test harness is working. Make this a habit, like how you check your car's dashboard for any warning lights before getting on the road. At the start of this exercise you should see JUnit report nine tests that are all ignored/disabled.

Scan the test code. Note that the method under test is `AuthorNameNormalize.normalize()`. Note the names of the test methods and get a sense of the behavior you're going to implement using TDD.

Once you get used to TDD, you'll come to expect more from tests than just verifying correctness of the code. You'll start to expect tests to tell a coherent story that helps you understand the purpose of the code. If they do this, you can expect the production code to be relatively easy to understand and work with.

Skimming over the tests in this exercise, I see a familiar pattern: This test code looks like it was guided by ZOMBIES.

### Using ZOMBIES to guide your TDD

James Grenning wrote an article about [TDD guided by ZOMBIES](https://blog.wingman-sw.com/tdd-guided-by-zombies). No, not the walking dead kind. Grenning's ZOMBIES stands for **Z**ero, **O**ne, **M**any, **B**oundaries, **I**nterfaces, **E**xceptions, and **S**imple Scenarios/Solutions. It's a helpful guide for thinking about what kind of tests to write and how to arrange test code so it tells a story that helps the reader build up their understanding, starting with the simplest scenarios and working up to more complex ones.

In this exercise, the Zero case is represented by an empty string, the One case represented by a one-word name, the Many case represented by two names, and so forth. The last test is an Exception case, where a name with multiple commas should cause an exception to be thrown.

The "S", for simple scenarios/simple solutions, is more of a general guideline that applies to all tests.

----

## Step 1 - Enable first test and see it fail

**What was done**

1. Deleted the `@Disabled` annotation on the first test (empty string).
2. Ran the test and saw it fail.

**Result**

    AuthorNameNormalizerTest > returns empty string when empty() FAILED
    kotlin.NotImplementedError at AuthorNameNormalizerTest.kt:10

    9 tests completed, 1 failed, 8 skipped

**Commentary**

Success! But wait, how can a failing test be a success?

TDD turns many things about development on its head. When you develop in a test-after manner by writing tests _after_ you've written the production code, a failing test means something isn't working the way you thought it would. Now you have to figure out what's wrong and fix it.

On the other hand, when you write a test _first_, as we do in TDD, a failing test represents progress. Why? Because the failure means there's functionality that's missing. Rather than going _back_ and fixing what was done, the failing test tells us to move forward and implement the missing functionality.

Note that the failing test is focused on a very specific aspect of behavior: the case when an empty string is passed in. This is a good test to start with because it's the simplest case. In the context of the ZOMBIES guideline, it represents Z(ero) and S(imple).

Commit: `. t (RED) Enable the empty string test and see it fail`

----

## Step 2 - Make the failing test pass

**What was done**

1. Make the failing empty string test pass by returning an empty string (`""`).

**Result**

    1 test passed, 8 ignored, 9 tests total

**Commentary**

A common reaction to this solution is something like "What? Why would you do that? That's obviously wrong!"

In his book "The Art of Agile Development", James Shore writes

> ...when you _first_ create a design element, whether it's a new method, a new class, or even a new architecture, be completely specific. Create a simple design that solves exactly the problem you face at the moment and nothing else, no matter how easy it may seem to solve more general problems.

Many people find TDD to be very counterintuitive when they first encounter it because as programmers, they are trained to write code that generalizes a solution. A solution that covers only this one specific scenario runs counter to this and it's hard to put that aside, even just for a little while.

Having to ignore instincts and ingrained habits makes TDD very uncomfortable and, understandably, it's usually the programmers with more years of experience who have strong negative reactions to TDD. Here are a few things to keep in mind to help you get past that natural discomfort:

>*"It is much better to do the right thing wronger than the wrong thing righter. If you do the right thing wrong and correct it, you get better."* —Russell L. Ackoff

1. Right now, the goal is to make the empty string scenario pass its test.
2. Hard-coding the return value [is the simplest thing that could possibly work](https://wiki.c2.com/?DoTheSimplestThingThatCouldPossiblyWork). In ZOMBIES terms, it's the simplest solution to the simplest scenario.
3. In TDD, we use a failing test to show that something is wrong rather than reasoning about it based on knowledge or intuition.
4. Here, doing the right thing (made the test pass) wrong (returned a hardcoded value) forces us to write another failing test to show that we need to make it better.
5. In TDD, we're not trying to get everything right at one go. TDD is an exercise in chipping away at what we don't know, one bit at a time. Eventually, we expect to get it right, if not everything, then at least most of it.

Commit comment: `. F (GREEN) make empty string test pass`

See also:
* "[Do The Simplest Thing That Could Possibly Work](https://www.ronjeffries.com/xprog/articles/practices/pracsimplest/)" by Ron Jeffries
* YouTube video: [If Russ Ackoff had given a TED Talk...](https://youtu.be/OqEeIG8aPPk?si=T8gKwRrC5Rba78ld)

----
