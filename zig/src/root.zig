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
    const actual = try normalize("");

    try std.testing.expectEqualStrings("", actual);
}

test "returns single word name" {
    const actual = try normalize("Plato");

    try std.testing.expectEqualStrings("Plato", actual);
}

test "swaps first and last names" {
    const actual = try normalize("Haruki Murakami");

    try std.testing.expectEqualStrings("Murakami, Haruki", actual);
}

test "trims leading and trailing whitespaces" {
    const actual = try normalize("  Big Boi   ");

    try std.testing.expectEqualStrings("Boi, Big", actual);
}

test "initializes middle name" {
    const actual = try normalize("Henry David Thoreau");

    try std.testing.expectEqualStrings("Thoreau, Henry D.", actual);
}

test "does not initialize one letter middle name" {
    const actual = try normalize("Harry S Truman");

    try std.testing.expectEqualStrings("Truman, Harry S", actual);
}

test "initializes each of multiple middle names" {
    const actual = try normalize("Julia Scarlett Elizabeth Louis-Dreyfus");

    try std.testing.expectEqualStrings("Louis-Dreyfus, Julia S. E.", actual);
}

test "appends suffixes to end" {
    const actual = try normalize("Martin Luther King, Jr.");

    try std.testing.expectEqualStrings("King, Martin L., Jr.", actual);
}

test "returns an error when name contains two commas" {
    const actual = normalize("Thurston, Howell, III");

    try std.testing.expectError(NameNormalizationError.MultipleCommas, actual);
}
