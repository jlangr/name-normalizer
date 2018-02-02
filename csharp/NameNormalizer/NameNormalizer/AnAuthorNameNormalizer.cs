using Xunit;
using FluentAssertions;
using System;
using Prod;

namespace Tests
{
    public class AnAuthorNameNormalizer
    {
        AuthorNameNormalizer normalizer;
        public AnAuthorNameNormalizer()
        {
            normalizer = new AuthorNameNormalizer();
        }

        [Fact(Skip="start here! Remove the skip argument.")]
        public void ReturnsEmptyStringWhenEmpty()
        {
            normalizer.Normalize("").Should().Be("");
        }

        [Fact(Skip="remove when ready")]
        public void ReturnsSingleWordName()
        {
            normalizer.Normalize("Plato").Should().Be("Plato");
        }

        [Fact(Skip="remove when ready")]
        public void ReturnsLastFirstWhenFirstLastProvided()
        {
            normalizer.Normalize("Haruki Murakami").Should().Be("Murakami, Haruki");
        }

        [Fact(Skip="remove when ready")]
        public void TrimsWhitespace()
        {
            normalizer.Normalize("   Big Boi    ").Should().Be("Boi, Big");
        }

        [Fact(Skip="remove when ready")]
        public void InitializesMiddleName()
        {
            normalizer.Normalize("Henry David Thoreau").Should().Be("Thoreau, Henry D.");
        }

        [Fact(Skip="remove when ready")]
        public void DoesNotInitializeOneLetterMiddleName()
        {
            normalizer.Normalize("Harry S Truman").Should().Be("Truman, Harry S");
        }

        [Fact(Skip="remove when ready")]
        public void InitializesEachOfMultipleMiddleNames()
        {
            normalizer.Normalize("Julia Scarlett Elizabeth Louis-Dreyfus").Should().Be("Louis-Dreyfus, Julia S. E.");
        }

        [Fact(Skip="remove when ready")]
        public void AppendsSuffixesToEnd()
        {
            normalizer.Normalize("Martin Luther King, Jr.").Should().Be("King, Martin L., Jr.");
        }

        [Fact(Skip="remove when ready")]
        public void ThrowsWhenNameContainsTwoCommas()
        {
            Action action = () => normalizer.Normalize("Thurston, Howell, III");

            action.ShouldThrow<ArgumentException>();
        }
    }
}