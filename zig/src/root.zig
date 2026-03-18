//! By convention, root.zig is the root source file when making a library.
const std = @import("std");

const NameNormalizationError = error{
    MultipleCommas,
};

fn normalize(name: []const u8) NameNormalizationError![]const u8 {
    // TODO Delete these lines and write your implementation
    _ = name;
    return "foobar";
}

test "returns empty string when empty" {
    try std.testing.expectEqual("", try normalize(""));
}

test "returns single word name" {
    try std.testing.expectEqual("Plato", try normalize("Plato"));
}

test "swaps first and last names" {
    try std.testing.expectEqual("Murakami, Haruki", try normalize("Haruki Murakami"));
}

test "trims leading and trailing whitespaces" {
    try std.testing.expectEqual("Boi, Big", try normalize("  Big Boi   "));
}

test "initializes middle name" {
    try std.testing.expectEqual("Thoreau, Henry D.", try normalize("Henry David Thoreau"));
}

test "does not initialize one letter middle name" {
    try std.testing.expectEqual("Truman, Harry S", try normalize("Harry S Truman"));
}

test "initializes each of multiple middle names" {
    try std.testing.expectEqual("Louis-Dreyfus, Julia S. E.", try normalize("Julia Scarlett Elizabeth Louis-Dreyfus"));
}

test "appends suffixes to end" {
    try std.testing.expectEqual("King, Martin L., Jr.", try normalize("Matrin Luther King, Jr."));
}

test "returns an error when name contains two commas" {
    try std.testing.expectError(NameNormalizationError.MultipleCommas, normalize("Thurston, Howell, III"));
}
