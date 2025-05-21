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

## Step 5 - Make the single word test pass

**What was done**

1. Return `name` instead of `""`

**Result**

    2 tests passed, 7 ignored, 9 tests total

**Commentary**

You might be thinking that this is exactly where we would have been a couple of steps ago if we had just returned `name` instead of the obviously wrong `""`. So what was point of taking the extra step to get to the same place? Isn't agile development supposed to make us go faster?

The long answer:

I've heard Kent Beck and other practitioners say that TDD is not about going faster but rather, having the option to go slower. If you think you can move forward with a bigger change, you can do that. If you think you made too big of a change and decide to backtrack and take a more measured approach, you can do that, too.

The key is to move forward methodically and with discipline. The TDD rhythm of Red-Green-Refactor gives us a way to grow our design methodically and deliberately:

1. Find a problem by writing a test focused on a specific scenario and see that it fails
2. Fix the problem by writing as little production code as possible to make the failing test pass
3. Refactor the code to make it reflect your current understanding as best you can so it's easy to understand what you were thinking and change it later as you learn more about the problem

It takes discipline to stick to this rhythm. A few things you get from taking smaller steps:

1. You are forced to tackle one simple scenario at a time. This leads to smaller increments of code. Smaller is simpler, bigger is more complex. Simpler changes are easier to understand and easier to refactor.
2. If you find that you need to back out the change, you're backing out a smaller change. Smaller changes are easier to back out than bigger changes.
3. Antoine de Saint-Exupéry said "A complex system that works is invariable found to have evolved from a simple system that works." Small increments are a key aspect of emergent design. The design evolves slowly in response to small stimuli and every evolutionary change has a specific reason to happen and is backed by tests.

Commit: `. F (GREEN) make the single word test pass`

----

## Step 6 - Refactor

At this point, it doesn't look like there's anything we can refactor so we will skip refactoring for now.

**What was done**

1. Made a conscious choice to skip refactoring

**Commentary**

No duplication, code expresses itself clearly, all tests pass, nothing to make simpler/smaller.

Commit: `. d Update notes to comment about skipping refactoring`

----

## Step 7 - Enable the swaps first and last names test and see it fail

**What was done**

1. Deleted `@Disabled` to enable the swaps first and last names test
2. Ran the test and saw it fail

**Result**

    org.opentest4j.AssertionFailedError: 
    expected: "Murakami, Haruki"
     but was: "Haruki Murakami"
	    at AuthorNameNormalizerTest.swaps first and last names(AuthorNameNormalizerTest.kt:23)

    9 tests completed, 1 failed, 6 skipped

**Commentary**

This is the Many case where the name contains more than one word. The test expects the first and last names to be swapped and separated by a comma and space.

Looking ahead at the other tests, you'll notice that this is a key piece of functionality that other expected behaviors rely on.

Commit: `. t (RED) Enable swap first and last name test and see it fail`

----

## Step 7 - Enable the swaps first and last names test and see it fail

**What was done**

1. Deleted `@Disabled` to enable the swaps first and last names test
2. Ran the test and saw it fail

**Result**

    org.opentest4j.AssertionFailedError: 
    expected: "Murakami, Haruki"
     but was: "Haruki Murakami"
	    at AuthorNameNormalizerTest.swaps first and last names(AuthorNameNormalizerTest.kt:23)

    9 tests completed, 1 failed, 6 skipped

**Commentary**

This is the Many case where the name contains more than one word. The test expects the first and last names to be swapped and separated by a comma and space.

Looking ahead at the other tests, you'll notice that this is a key piece of functionality that other expected behaviors rely on.

Commit: `. t (RED) Enable swap first and last name test and see it fail`

----

## Step 8 - Make the swap first and last names test pass

**What was done**

1. Separate the name parts using `split()`
2. Format the name, last name first, separated by a comma

**Result**

    3 tests passed, 6 ignored, 9 tests total

**Commentary**

This is the biggest change we've made so far: a whopping four new lines of code! First, we used [split()](https://kotlinlang.org/api/core/kotlin-stdlib/kotlin.text/split.html) to separate the words in the name. We then formatted the name using a [string template])(https://kotlinlang.org/docs/strings.html#string-templates). 

You might cringe at the thought of using specific indices to pick out the first and last names. Your gut might tell you that this is probably wrong but again, we're going to use this to lead us to a more general solution. Since this scenario deals specifically with a name that has only two words, this works for now and gets us quickly to green.

Commit: `. F (GREEN) implement swap first and last names functionality.`

----

## Step 9 - Refactoring

**What was done**

1. Extracted the expression to check if name has multiple words

**Result**

    3 tests passed, 6 ignored, 9 tests total

**Commentary**

The expression `name.contains(' ')` is a good candidate for extraction. It's a simple expression but it doesn't quite align with the verbal explanation of "name contains multiple words". Extracting it to a private function and giving it a name like `isMultiPart()` makes its intent clearer. Again, dual coding helped highlight this refactoring opportunity:

    Verbal info: Does the name contain multiple words?
    Visual info: name.contains(' ')

Hiding the implementation detail in a private function named `isMultiPart()` clarifies the intent of the code and makes it easier to understand.

Commit: `. r Extract method to clarify intent of checking for multipart names.`

----

## Step 10 - Refactoring

**What was done**

1. Converted the `name` parameter in `isMultiPart()` to a receiver.

**Result**

    3 tests passed, 6 ignored, 9 tests total

**Commentary**

This is a small refactoring to improve the semantics of the code and make it a little more readable.

By converting the `isMultiPart()` function into an [extension functions](https://kotlinlang.org/docs/kotlin-tour-intermediate-extension-functions.html) of `String`, `name` becomes the receiver of the function call instead of being passed in as a parameter.

Compare the two versions of the call:

    // version 1 - name is a parameter
    if (isMultiPart(name))

    // version 2 - name is the receiver
    if (name.isMultiPart())

This is largely a matter of style but it's a nice feature that allows you to improve the readability of your code.

Commit comment: `. r Convert isMultiPart name parameter to a receiver`

----

## Step 11 - Refactoring

**What was done**

1. Extracted the expression to split the name into its parts
2. Converted the `name` parameter in `parts()` to a receiver.

**Result**

    3 tests passed, 6 ignored, 9 tests total

**Commentary**

Similar to the previous refactoring, this refactoring improves the semantics of the code and makes it a little more readable by extracting the expression to split the name into parts, then converting the `name` parameter to a receiver.

Note that it's normal to have multiple refactoring steps in a row. Committing each refactoring step separately allows you to easily backtrack to any previous step. Again, finer-grained refactorings allows you to keep your options for evolving the design open to more possible paths.

Commit comment: `. r Extract expression to parts() and convert name parameter to a receiver.`

----

## Step 12 - Enable trims leading and trailing whitespace test and see it fail.

**What was done**

1. Deleted `@Disabled` to enable the trims leading and trailing whitespace test
2. Ran the test and saw it fail

**Result**

    AuthorNameNormalizerTest > trims leading and trailing whitespace() FAILED
    org.opentest4j.AssertionFailedError: 
    expected: "Boi, Big"
     but was: ", "
        at app//AuthorNameNormalizerTest.trims leading and trailing whitespace(AuthorNameNormalizerTest.kt:29)

    9 tests completed, 1 failed, 5 skipped

**Commentary**

The test expects leading and trailing whitespaces to be trimmed from the name. The test fails because the current solution doesn't trim the name.

Commit comment: `. t (RED) Enable trim leading and trailing whitespace test and see it fail`

----


## Step 13 - Make the trims leading and trailing whitespace test pass

**What was done**

1. Manually renamed the `name` parameter to `rawName`
2. Trimmed `rawName` and assigned the result to a new local variable `name`

**Result**

    4 tests passed, 5 ignored, 9 tests total

**Commentary**

This change posed a slight risk because I manually renamed the `name` parameter to `rawName`. The risk, however, was minimal because the function is still very short. At first, I introduced a `trimmed` local variable to store the trimmed name and then changed all the references to `name` after that to `trimmedName`. I decided to revert and keep the semantics for `name` instead. Introducing `rawName` to represent the original, unmodified name involves fewer changes making it less risky. The name `rawName` might not be the best but it is good enough for now. I'll refactor it later if I think of a better name.

Commit comment: `^ F (GREEN) Implement trims leading and trailing whitespace functionality`

----

## Step 14 - Refactoring

**What was done**

1. Rename `rawName` to `authorName`

**Result**

    4 tests passed, 5 ignored, 9 tests total

**Commentary**

I decided to rename `rawName` to `authorName` to make it more consistent with the verbal explanation of the function. The name is arguably redundant because the enclosing class already conveys the same idea. However, I chose to live with this redundancy rather than introduce a new concept like raw name.

Commit comment: `. r Refactor rawName to authorName`

----

## Step 15 - Enable initializes middle name test and see it fail

**What was done**

1. Deleted `@Disabled` to enable the initializes middle name test
2. Ran the test and saw it fail

**Result**

    AuthorNameNormalizerTest > initializes middle name() FAILED
    org.opentest4j.AssertionFailedError: 
    expected: "Thoreau, Henry D."
     but was: "David, Henry"
        at app//AuthorNameNormalizerTest.initializes middle name(AuthorNameNormalizerTest.kt:35)

    9 tests completed, 1 failed, 4 skipped

**Commentary**

This failing test reveals two problems in the current solution.

1. Bug: It picks up the wrong last name (David instead of Thoreau)
2. Missing behavior: It doesn't initialize the middle name

Commit comment: `. t (RED) Enable initializes middle name test and see it fail`

----

## Step 16 - Make the initializes middle name test pass

**What was done**

1. Fixed the problem with the last name
2. Added logic to initialize the middle name
3. Added the middle initial to the end of the first name

**Result**

    5 tests passed, 4 ignored, 9 tests total

**Commentary**

This is the biggest change made to the solution so far.

First, we had to fix the problem with the wrong last name being picked up. The bug was caused by hardcoding `parts[1]` as the last name. This fails if the name has more than two parts. We eliminate the bug by replacing `parts[1]` with `parts.last()`. For symmetry, we also replace `parts[0]` with `parts.first()`.

The logic for initializing the middle name works but is a bit messy and unclear. We'll refactor it for clarity in the next step.

Commit comment: `. F (GREEN) implement initializes middle name functionality`

----

## Step 17 - Refactoring

**What was done**

1. Renamed `middle` to `middleInitial`
2. Extracted the logic for picking out the middle name to `middle()`

**Result**

    5 tests passed, 4 ignored, 9 tests total

**Commentary**

This starts to clarify the intent of the code to initialize the middle name. We start by renaming the `middle` variable so it expresses its purpose more completely. We then extract the logic that extracts the middle name(s) to a private function.

Prior to this I tried extracting the entire right side of the assignment to `middle()` but it turned out to be too big of a change for what I wanted to do, which was to be able to write:

    val middleInitial = initialize(middle(parts))

I had considered refactoring to this:

    val middleInitial = middle(parts).initialized()

but decided to go with the former because it aligned better with my verbal explanation.

Commit comment: `. r Rename middle to middleInitial and extract logic to pick out middle name`

----

## Step 18 - Continue refactoring

**What was done**

1. Introduced a variable to facilitate automated refactoring to `initialize(middle(parts))`

**Result**

    5 tests passed, 4 ignored, 9 tests total

**Commentary**

My first refactoring attempt was too big and the expression `middle(parts)` ended up getting extracted along with the rest of the code, which I didn't want to happen. To prevent this, I needed to introduce a temporary variable.

This is an intermediate refactoring step that will be reverted with an Inline variable refactoring later once the target code is in place. This step helps me use automated refactoring rather than manually editing the code. It may seem a bit roundabout and more tedious but automated refactoring is less risky and the additional step only takes a few seconds to do.

Commit comment: `. r Introduce middleNames variable in preparation for next refactoring steps`

----

## Step 19 - Complete refactoring

**What was done**

1. Complete refactoring to `initialize(middle(parts))`

**Result**

    5 tests passed, 4 ignored, 9 tests total

**Commentary**

After extracting the right-hand side of the assignment to a private function, we can now inline the `middleInitials` variable and get the code we wanted: 

    val middleInitial = initialize(middle(parts))

This reads very nicely and clearly expresses its intent.

Commit comment: `. r Extract right-hand side of the middleInitial assignment and inline the middleNames variable`

----

## Step 20 - Enable test for not initializing one-letter middle name

**What was done**

1. Deleted `@Disabled` to enable the one-letter middle name test
2. Run the test and see it fail

**Result**

    AuthorNameNormalizerTest > does not initialize one letter middle name() FAILED
    org.opentest4j.AssertionFailedError: 
    expected: "Truman, Harry S"
     but was: "Truman, Harry S."
        at app//AuthorNameNormalizerTest.does not initialize one letter middle name(AuthorNameNormalizerTest.kt:41)

     9 tests completed, 1 failed, 3 skipped

**Commentary**

The test expects one-letter middle names to not be initialized. It fails because the current solution doesn't check for one-letter middle names.

Commit comment: `. t (RED) Enable one-letter middle name not initialized test`

----

## Step 21 - Implement one-letter middle name not initialized logic

**What was done**

1. Added check for more than one letter in name

**Result**

    6 tests passed, 3 ignored, 9 tests total

**Commentary**

Only names that have more than one letter will be initialized.

Commit comment: `. F Add check so only middle names with more than one letter are initialized`

----

## Step 22 - Tidy up for reading order

**What was done**

1. Tidied up for reading order

**Result**

    6 tests passed, 3 ignored, 9 tests total

**Commentary**

This is from Kent Beck's "Tidy First?" book. Arranging the functions in reading/encounter order helps makes the code easier to scan.

Commit comment: `. r Tidy up for reading order`

----

## Step 23 - Enable multiple middle names test

**What was done**

1. Deleted `@Disabled` to enable the initializes multiple middle names test
2. Run the test and see it fail

**Result**

    7 tests passed, 2 ignored, 9 tests total

**Commentary**

This test immediately passed which would normally raise some questions about the validity of the test. A quick analysis shows that it didn't fail because the logic already accounts for multiple middle names. We might consider combining this with the other tests for initializing middle name but for now we'll move on to the next step.

I am marking it as validated to call out that the risk was noted and considered low.

Commit comment: `^ t (GREEN) Enable initializing multiple middle names test`

----

## Step 24 - Rename to middleInitials

**What we did**

1. Rename `middleInitial` to make it plural

**Result**

    7 tests passed, 2 ignored, 9 tests total

**Commentary**

A small refactoring to align the semantics with the code's behavior: The value can represent multiple middle initials.

Commit comment: `. r Rename variable to middleInitials`

----

## Step 25 - Enable test for suffix

**What was done**

1. Deleted `@Disabled` to enable the test for appending the suffix
2. Run the test and see it fail

**Result**

    AuthorNameNormalizerTest > appends suffixes to end() FAILED
    org.opentest4j.AssertionFailedError: 
    expected: "King, Martin L., Jr."
     but was: "Jr., Martin L. K."
        at app//AuthorNameNormalizerTest.appends suffixes to end(AuthorNameNormalizerTest.kt:53)

    9 tests completed, 1 failed, 1 skipped

**Commentary**

The test fails because the logic to append a suffix is missing.

Commit comment: `. t (RED) Enable test to append suffix`

----

## Step 26 - Implement behavior for appending suffix

**What was done**

1. Modified the `parts()` function, making it return a `Pair(List<String>, String)` instead of just a `String`

**Result**

    8 tests passed, 1 ignored, 9 tests total

**Commentary**

The bulk of the change was made in the `parts()` function. This is a relatively large change compared to other changes made so far. Even though the return type was changed from a simple `String` to a `Pair(List<String>, String)`, Kotlin's ability to infer types makes this change relatively painless. Note the destructuring of the return value on line 5, which allows us to keep using `parts` while also adding a new variable, `suffix` into the mix.

Commit comment: `. F Add logic to extract and append a suffix`

----

## Step 27 - Refactoring for clarity and style

**What was done**

1. Converted if expression to when expression
2. Extracted check for `", "` to a private function

**Result**

    8 tests passed, 1 ignored, 9 tests total

**Commentary**

Converting to a when expression is more of a matter of style. The when expression seems to be a preferred form in Kotlin.

The extract function makes the intent of the suffix check clear and expressed in the language of the problem (has suffix rather than contains a comma). 

Commit comment: `. r Convert if to when for style and extract to hasSuffix() function`

----

## Step 28 - Enable multiple comma throws exception test

**What was done**

1. Deleted `@Disabled` to enable the test for appending the suffix
2. Run the test and see it fail

**Result**

    AuthorNameNormalizerTest > throws when name contains two commas() FAILED
    java.lang.AssertionError: 
    Expecting code to raise a throwable.
        at AuthorNameNormalizerTest.throws when name contains two commas(AuthorNameNormalizerTest.kt:59)

    9 tests completed, 1 failed

**Commentary**

Test fails because the solution doesn't check for multiple commas in the incoming name.

Commit comment: `.t (RED) Enable the throws exception with multiple commas test`

----

## Step 29 - Implement check for multiple commas

**What was done**

1. Added logic to check for multiple commas

**Result**

    9 tests passed, 9 tests total

**Commentary**

Added a check for multiple commas and throw an `IllegalArgumentException` with the expected message.

Commit comment: `. F (GREEN) Implement check for multiple commas`

----

## Step 30 - Refactoring

**What was done**

1. Lift the return out of the if statement in the main function
2. Convert the if expression to a when expression

**Result**

    9 tests passed, 9 tests total

**Commentary**

This is style-related refactoring that moves the `return` out of the if statement. Then we convert the if to a when.

Commit comment: `. r Replace if with return and convert it to when.`

----

## Step 31 - Compose function

**What was done**

1. Extracted functions to make `parts()` more composed.

**Result**

    9 tests passed, 9 tests total

**Commentary**

This might be going a bit farther than what most people would do but I think it's still worth spending a couple of minutes to make the code more composed and readable.

Commit comment: `. r Compose the parts() function`

----

## Step 32 - Get rid of compiler warning

**What was done**

1. Deleted unused import for `@Disabled` annotation.

**Result**

    9 tests passed, 9 tests total

**Commentary**

Gets rid of the compiler warning about the unused import.

Commit comment: `. r Resolve compiler warning about unused import for @Disabled`

----

## Step 33 - Tidy for reading order

**What was done**

1. Reordered functions to reading order

**Result**

    9 tests passed, 9 tests total

**Commentary**

Tidy up to arrange code in reading order.

Commit comment: `. r Tidy up for reading order`

----

## Additional Exercises

At this point, all the existing tests are passing and the code looks relatively clean. There are other things you could experiment with such as using parameterized tests to combine some tests into one. For example, you could combine the tests related to middle initials into one test. Try it and see how you like how the test code reads. One question I would ask is whether the combined test scenarios are closely related to each other or if they are different enough to warrant keeping them as separate tests. 

Another piece of advice I have related to this is to always try coding ideas you have. I often find things that seemed like a good idea in my head don't turn out to be so good when I see it in code. The converse is also true where things that don't seem like very good ideas turn out to be quite good when expressed in code. Don't leave anything to the imagination: Code It!

Happy coding!
