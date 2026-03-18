//! By convention, root.zig is the root source file when making a library.
const std = @import("std");

const NameNormalizationError = error{
    MultipleCommas,
};

fn normalize(allocator: std.mem.Allocator, name: []const u8) NameNormalizationError![]const u8 {
    // TODO Delete these lines and write your implementation
    _ = allocator;
    _ = name;
    return "foobar";
}

test "returns empty string when empty" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "");

    try std.testing.expectEqualStrings("", actual);
}

test "returns single word name" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Plato");

    try std.testing.expectEqualStrings("Plato", actual);
}

test "swaps first and last names" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Haruki Murakami");

    try std.testing.expectEqualStrings("Murakami, Haruki", actual);
}

test "trims leading and trailing whitespaces" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "  Big Boi   ");

    try std.testing.expectEqualStrings("Boi, Big", actual);
}

test "initializes middle name" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize("Henry David Thoreau");

    try std.testing.expectEqualStrings(allocator, "Thoreau, Henry D.", actual);
}

test "does not initialize one letter middle name" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Harry S Truman");

    try std.testing.expectEqualStrings("Truman, Harry S", actual);
}

test "initializes each of multiple middle names" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Julia Scarlett Elizabeth Louis-Dreyfus");

    try std.testing.expectEqualStrings("Louis-Dreyfus, Julia S. E.", actual);
}

test "appends suffixes to end" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Martin Luther King, Jr.");

    try std.testing.expectEqualStrings("King, Martin L., Jr.", actual);
}

test "returns an error when name contains two commas" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = normalize(allocator, "Thurston, Howell, III");

    try std.testing.expectError(NameNormalizationError.MultipleCommas, actual);
}
