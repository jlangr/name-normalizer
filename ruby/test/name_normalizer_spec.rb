require "../lib/name_normalizer"

describe NameNormalizer do
  let(:normalizer) { NameNormalizer.new }

  it "returns the empty string when passed an empty string" do
    expect(normalizer.normalize "").to eq ""
  end

  it "returns a monomym when passed one" do
    expect(normalizer.normalize "Plato").to eq "Plato"
  end

  it "swaps first and last names" do
    expect(normalizer.normalize "Haruki Murakami").to eq "Murakami, Haruki"
  end

  it "trims leading and trailing whitespace" do
    expect(normalizer.normalize "   Big Boi    ").to eq "Boi, Big"
  end

  it "initializes middle name" do
    expect(normalizer.normalize "Henry David Thoreau").to eq "Thoreau, Henry D."
  end

  it "does not initialize one-letter middle name" do
    expect(normalizer.normalize "Harry S Truman").to eq "Truman, Harry S"
  end

  it "initializes each of multiple middle names" do
    expect(normalizer.normalize "Julia Scarlett Elizabeth Louis-Dreyfus").to eq "Louis-Dreyfus, Julia S. E."
  end

  it "appends suffixes to end" do
    expect(normalizer.normalize "Martin Luther King, Jr.").to eq "King, Martin L., Jr."
  end

  it "throws when name contains too many commas" do
    expect { normalizer.normalize "Thurston, Howell, III" }.to raise_error(ArgumentError)
  end
end