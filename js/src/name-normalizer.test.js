import { nameNormalizer } from './name-normalizer';

describe('a name normalizer', () => {
  it('returns empty when passed empty string', () => {
    expect(nameNormalizer("")).toEqual("");
  });

  xit('returns single word name', () => {
    expect(nameNormalizer.normalize("Plato")).toEqual("Plato");
  });

  xit('swaps first and last names', () => {
      expect(nameNormalizer.normalize("Haruki Murakami")).toEqual("Murakami, Haruki");
  });

  xit('trims leading and trailing whitespace', () => {
      expect(nameNormalizer.normalize("  Big Boi   ")).toEqual("Boi, Big");
  });

  xit('initializes middle name', () => {
      expect(nameNormalizer.normalize("Henry David Thoreau")).toEqual("Thoreau, Henry D.");
  });

  xit('does not initialize one letter middle name', () => {
      expect(nameNormalizer.normalize("Harry S Truman")).toEqual("Truman, Harry S");
  });

  xit('initializes each of multiple middle names', () => {
      expect(nameNormalizer.normalize("Julia Scarlett Elizabeth Louis-Dreyfus")).toEqual("Louis-Dreyfus, Julia S. E.");
  });

  xit('appends suffixes to end', () => {
      expect(nameNormalizer.normalize("Martin Luther King, Jr.")).toEqual("King, Martin L., Jr.");
  });

  xit('throws when name contains two commas', () => {
    expect(() => { normalizer.normalize("Thurston, Howell, III") }).toThrow();
  });
});
