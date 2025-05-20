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

## Step 3 - Refactor

**Commentary**

Refactoring tends to be the most skipped step in TDD, especially in the early going when changes to the code seem minimal or trivial. Unfortunately, the longer you put off refactoring, the more difficult it becomes and the more you tend to overlook small details, thus reducing the value you get out of TDD.

Skipping the refactoring step once or twice is not the end of the world, but if you find yourself skipping it multiple times in a row, you might be accumulating too many changes. The smaller the change, the easier it will be to refactor. The longer you put off refactoring, the more chances there are for the code to become more resistant to refactoring.

Key practice: Refactor sooner rather than later and make the code reflect your current understanding as best as you can at all times.

See also: YouTube video where [Ward explains the Debt Metaphor](https://youtu.be/pqeJFYwnkjE?si=QmmrLTV7o3unWyvX) or read the [transcript](https://wiki.c2.com/?WardExplainsDebtMetaphor).

At this point, you might be tempted to skip refactoring and go on to the next step. However, if you take a minute to read the code and check it for duplication and clarity of intent (see [the four rules of simple design](https://martinfowler.com/bliki/BeckDesignRules.html)), you might notice that the parameter `s` of the `normalize()` function doesn't express its intent very well.

### Dual Coding: Finding opportunities to refactor

Dual coding is a learning strategy that I often use to find opportunities to refactor. It's essentially this:

1. Combine visual and verbal information
2. Explain the visuals in your own words

With code, the visual information is the code itself that you're reading. The verbal information comes from explaining the code out loud in your own words. By combining visual and verbal information this way, it's easier to notice differences between how the code is written and how someone reading it might interpret it.

Try this: Read the code _out loud_, don't just vocalize it in your head. If you're programming in a pair or mob, have the navigator read the code out loud and explain its intent in their own words. Read the code as you listen to the explanation. This will activate the visual and verbal/listening input channels to your brain. Look out for discrepancies between what you're reading and what you're hearing.

If I were to explain the code we have at this point in my own words, I might say "The normalize function takes a _name_ and returns _an empty string_."

When I hear myself say "takes a name" but see the parameter `s` in the code, I recognize this as a translation that adds cognitive load on the reader. Translations like this often go unnoticed, mainly because programmers do it all the time and are used to it. Renaming `s` to `name` clarifies the code's intent and improves its readability.

This may seem trivial and even nitpicky at first but having good names that clearly express the code's intent is a cornerstone of simple design and readable code. Once you get used to writing and reading code that clearly expresses its intent, you'll become more sensitive to the extra effort it takes to read code that doesn't and thus be able to find more opportunities to refactor.

*Pro Tip*: Practice dual coding during the refactoring step to develop a sensitivity to code that could be refactored to express its intent more clearly.

One might also argue that the same kind of cognitive load exists with "returns an empty string" and the code `return ""` and introduce a constant like `EMPTY_STRING`. I didn't choose to go that far because I knew that that line would change or be eliminated later anyway.

**What we changed**

1. Make the parameter `s` express its intent by renaming it to `name`

**Result**

    1 test passed, 8 ignored, 9 tests total

Commit comment: `. r Refactor to make parameter express its intent`

### References

* [Dual Coding and Learning Styles](https://www.learningscientists.org/blog/2019/6/6-1)
* [Four Rules of Simple Design](https://martinfowler.com/bliki/BeckDesignRules.html)

----

## Step 4 - Enable single word test

**What was done**

1. Deleted `@Disabled` to enable the single word test
2. Ran the test and saw it fail

**Result**

    AuthorNameNormalizerTest > returns single word name() FAILED
    org.opentest4j.AssertionFailedError: 
    expected: "Plato"
     but was: ""
        at app//AuthorNameNormalizerTest.returns single word name(AuthorNameNormalizerTest.kt:17)

    9 tests completed, 1 failed, 7 skipped

**Commentary**

This test failed because of our choice to return a hard-coded empty string in Step 2.

When doing TDD, we use a failing test to show that something is wrong rather than try reasoning about it. The test we enabled focuses on the scenario where a single word name is passed in. Since the current solution only solves for the empty string case, it's not going to work for other types of input. The failing test shows that. This codifies our understanding of the problem and allows us to share that understanding with others.

Here are a few other reasons to see this failing test as a positive:

1. We can now make changes to the solution code to fix what's wrong.
2. Going forward, this test will do the heavy lifting of verifying this aspect of behavior for us.
3. This test will help detect regressions and facilitate refactoring.
4. This test will give us ideas for what other tests we can write next.

Commit message: `. t (RED) enable single word test and see it fail`

### An Alternative Path

In different iterations of this exercise, I made the first test pass by returning `s` instead of `""`. That decision led to this test passing immediately after it was enabled. That slightly changed the trajectory the solution took.

If a test passes without failing first, ask these questions:

1. Is this test redundant? Should it be deleted?
2. Did we miss a scenario? Is there a smaller step that could be taken, one where this test will fail?
3. Do we understand why this test didn't fail?
4. Does this reveal a gap in our understanding?

### Experiment to Gain Deeper Insights

Imagine for a minute that this exercise didn't have tests already written. If you had to come up with tests yourself, would you have thought to test for a single word? Does the order in which you write tests matter? Would adding tests in a different order change the outcome?

Explore the answers to these questions by experimenting with different choices. Where do those choices lead you? How do you use tests to keep moving forward? Experimenting with different choices and reflecting on the results is a great way to gain deeper insights about TDD.

----