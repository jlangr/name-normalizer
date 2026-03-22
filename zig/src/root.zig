//! By convention, root.zig is the root source file when making a library.
const std = @import("std");

// Increment this when all currently running tests are passing successfully.
// Max tests: 9
const ENABLED_TESTS = 1;

const NameNormalizationError = error{
    MultipleCommas,
};

fn normalize(allocator: std.mem.Allocator, name: []const u8) ![]const u8 {
    _ = allocator;
    _ = name;
    return "foobar";
}

test "returns empty string when empty" {
    if (ENABLED_TESTS < 1) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "");

    try std.testing.expectEqualStrings("", actual);
}

test "returns single word name" {
    if (ENABLED_TESTS < 2) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Plato");

    try std.testing.expectEqualStrings("Plato", actual);
}

test "swaps first and last names" {
    if (ENABLED_TESTS < 3) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Haruki Murakami");

    try std.testing.expectEqualStrings("Murakami, Haruki", actual);
}

test "trims leading and trailing whitespaces" {
    if (ENABLED_TESTS < 4) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "  Big Boi   ");

    try std.testing.expectEqualStrings("Boi, Big", actual);
}

test "initializes middle name" {
    if (ENABLED_TESTS < 5) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Henry David Thoreau");

    try std.testing.expectEqualStrings("Thoreau, Henry D.", actual);
}

test "does not initialize one letter middle name" {
    if (ENABLED_TESTS < 6) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Harry S Truman");

    try std.testing.expectEqualStrings("Truman, Harry S", actual);
}

test "initializes each of multiple middle names" {
    if (ENABLED_TESTS < 7) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Julia Scarlett Elizabeth Louis-Dreyfus");

    try std.testing.expectEqualStrings("Louis-Dreyfus, Julia S. E.", actual);
}

test "appends suffixes to end" {
    if (ENABLED_TESTS < 8) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Martin Luther King, Jr.");

    try std.testing.expectEqualStrings("King, Martin L., Jr.", actual);
}

test "returns an error when name contains two commas" {
    if (ENABLED_TESTS < 9) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = normalize(allocator, "Thurston, Howell, III");

    try std.testing.expectError(NameNormalizationError.MultipleCommas, actual);
}
