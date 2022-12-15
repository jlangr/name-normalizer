import { normalize } from './name-normalizer'

describe('a name normalizer', () => {
  it('returns empty when passed empty string', () =>
    expect(normalize("")).toEqual(""))

  it('returns single word name', () =>
    expect(normalize("Plato")).toEqual("Plato"))

  it('swaps first and last names', () =>
      expect(normalize("Haruki Murakami")).toEqual("Murakami, Haruki"))

  it('trims leading and trailing whitespace', () =>
      expect(normalize("  Big Boi   ")).toEqual("Boi, Big"))

  xit('initializes middle name', () =>
      expect(normalize("Henry David Thoreau")).toEqual("Thoreau, Henry D."))

  xit('does not initialize one letter middle name', () =>
      expect(normalize("Harry S Truman")).toEqual("Truman, Harry S"))

  xit('initializes each of multiple middle names', () =>
      expect(normalize("Julia Scarlett Elizabeth Louis-Dreyfus"))
          .toEqual("Louis-Dreyfus, Julia S. E."))

  xit('appends suffixes to end', () =>
      expect(normalize("Martin Luther King, Jr.")).toEqual("King, Martin L., Jr."))

  xit('throws when name contains two commas', () =>
    expect(() => { normalize("Thurston, Howell, III") }).toThrow())
})
