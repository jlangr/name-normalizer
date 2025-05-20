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